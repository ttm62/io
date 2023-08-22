//
//  MapVC.swift
//  io
//
//  Created by gv on 21/08/2023.
//

import UIKit
import GoogleMaps

enum TripMode: String {
    case confirm
    case placeRide
    case searching
    case onRide
    
    var cellCount: Int {
        switch self {
        case .confirm:
            return 3 // place info, driver note, confirm button
        case .placeRide:
            return 3 // vehicle selection, pay method, confirm button
        case .searching:
            return 2 // vehicle, driver searching
        case .onRide:
            return 3 // driver status, driver info, detail button
        }
    }
}

class MapVC: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    
    let camera: GMSCameraPosition = GMSCameraPosition.camera(
        withLatitude: -33.86, longitude: 151.20, zoom: 12
    )
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.mapView = .init(frame: .zero, camera: camera)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        configKeyboardNotification(for: bottomViewConstraint)
    }
}


extension MapVC {
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
            let bottomConstant: CGFloat = 20
            viewBottomConstraint.constant = keyboardHeight + (safeAreaExists ? 0 : bottomConstant)
        } else {
            viewBottomConstraint.constant = 20
        }
        
        // Animate the view the same way the keyboard animates
        let animator = UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
            // Update Constraints
            self?.view.layoutIfNeeded()
        }
        
        // Perform the animation
        animator.startAnimation()
//        bottomTable.reloadData()
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
