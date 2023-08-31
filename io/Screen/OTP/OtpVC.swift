//
//  OtpVC.swift
//  io
//
//  Created by gv on 14/08/2023.
//

import UIKit
// import AEOTPTextField

final
class OtpVC: UIViewController {
    
    // @IBOutlet weak var otpField: AEOTPTextField!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var otpCountDown: UILabel!
    
    private var timer: Timer?
    private var currentOTPBreakTime: Int = 60 {
        didSet {
            otpCountDown.text = "(\(self.currentOTPBreakTime)s)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        configKeyboardNotification(for: bottomViewConstraint)
        
//        otpField.delegate = self
//        otpField.otpFont = .systemFont(ofSize: 20)
//        otpField.configure(with: 4)
//        otpField.backgroundColor = .clear
//        otpField.otpTextColor = .black
        
        self.timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(handleTimerExecution),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func handleTimerExecution() {
        if self.currentOTPBreakTime == 0 {
            self.timer?.invalidate() // invalidating timer
        } else {
            self.currentOTPBreakTime -= 1
        }
        
        print("(\(self.currentOTPBreakTime)s)")
    }
    
    @IBAction func didTapContinue() {
        currentOTPBreakTime = 60
    }
}

extension OtpVC {
    func configKeyboardNotification(for bottomConstraint: NSLayoutConstraint) {
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func moveViewWithKeyboard(notification: NSNotification, viewBottomConstraint: NSLayoutConstraint, keyboardWillShow: Bool) {
        // Keyboard's size
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        
        // Keyboard's animation duration
        let keyboardDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        // Keyboard's animation curve
        let keyboardCurve = UIView.AnimationCurve(rawValue: notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
        
        // Change the constant
        if keyboardWillShow {
            let safeAreaExists = (self.view?.window?.safeAreaInsets.bottom != 0) // Check if safe area exists
            let bottomConstant: CGFloat = 0
            viewBottomConstraint.constant = keyboardHeight + (safeAreaExists ? 0 : bottomConstant)
        } else {
            viewBottomConstraint.constant = 0
        }
        
        // Animate the view the same way the keyboard animates
        let animator = UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
            // Update Constraints
            self?.view.layoutIfNeeded()
        }
        
        // Perform the animation
        animator.startAnimation()
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        moveViewWithKeyboard(
            notification: notification,
            viewBottomConstraint: self.bottomViewConstraint,
            keyboardWillShow: false
        )
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        moveViewWithKeyboard(
            notification: notification,
            viewBottomConstraint: self.bottomViewConstraint,
            keyboardWillShow: true
        )
    }
}


// MARK: Close keyboard when you press 'return'
extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Hide keyboard
typealias EmptyHandler = () -> Void
extension UIViewController {
    func hideKeyboardWhenTappedAround(compeltion: EmptyHandler? = nil) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: UIGestureRecognizer + closure
extension UIGestureRecognizer {
    typealias Action = ((UIGestureRecognizer) -> ())
    
    private struct Keys {
        static var actionKey = "ActionKey"
    }
    
    private var block: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &Keys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        
        get {
            let action = objc_getAssociatedObject(self, &Keys.actionKey) as? Action
            return action
        }
    }
    
    @objc func handleAction(recognizer: UIGestureRecognizer) {
        block?(recognizer)
    }
    
    convenience public  init(block: @escaping ((UIGestureRecognizer) -> ())) {
        self.init()
        self.block = block
        self.addTarget(self, action: #selector(handleAction(recognizer:)))
    }
}
