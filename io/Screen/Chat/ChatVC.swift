//
//  ChatVC.swift
//  io
//
//  Created by gv on 23/08/2023.
//

import UIKit

class ChatVC: UIViewController {
    
    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    
    var chats: [ChatContent] = [
        .me("Chào bạn"),
        .other("Bạn đã đến điểm đón chưa. Tôi đang trên đường đón bạn rồi."),
        .me("Tôi đã đến nơi rồi. Bao lâu nữa thì bạn đến nhỉ?"),
        .other("Ok bạn. 2 phút nữa tôi đến."),
        .me("Chào bạn"),
        .other("Bạn đã đến điểm đón chưa. Tôi đang trên đường đón bạn rồi."),
        .me("Tôi đã đến nơi rồi. Bao lâu nữa thì bạn đến nhỉ?"),
        .other("Ok bạn. 2 phút nữa tôi đến."),
        .me("Chào bạn"),
        .other("Bạn đã đến điểm đón chưa. Tôi đang trên đường đón bạn rồi."),
        .me("Tôi đã đến nơi rồi. Bao lâu nữa thì bạn đến nhỉ?"),
        .other("Ok bạn. 2 phút nữa tôi đến."),
        .me("Chào bạn"),
        .other("Bạn đã đến điểm đón chưa. Tôi đang trên đường đón bạn rồi."),
        .me("Tôi đã đến nơi rồi. Bao lâu nữa thì bạn đến nhỉ?"),
        .other("Ok bạn. 2 phút nữa tôi đến."),
        .me("Chào bạn"),
        .other("Bạn đã đến điểm đón chưa. Tôi đang trên đường đón bạn rồi."),
        .me("Tôi đã đến nơi rồi. Bao lâu nữa thì bạn đến nhỉ?"),
        .other("Ok bạn. 2 phút nữa tôi đến."),
        .me("Chào bạn"),
        .other("Bạn đã đến điểm đón chưa. Tôi đang trên đường đón bạn rồi."),
        .me("Tôi đã đến nơi rồi. Bao lâu nữa thì bạn đến nhỉ?"),
        .other("Ok bạn. 2 phút nữa tôi đến."),
        .me("Chào bạn"),
        .other("Bạn đã đến điểm đón chưa. Tôi đang trên đường đón bạn rồi."),
        .me("Tôi đã đến nơi rồi. Bao lâu nữa thì bạn đến nhỉ?"),
        .other("Ok bạn. 2 phút nữa tôi đến."),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        configKeyboardNotification(for: bottomConstraint)
        
        chatTable.delegate = self
        chatTable.dataSource = self
        chatTable.register(MeChatCell.self)
        chatTable.register(OtherChatCell.self)
        chatTable.rowHeight = UITableView.automaticDimension
        chatTable.separatorColor = .clear
    }
}

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let content = chats[safe: indexPath.row] {
            switch content {
            case .me(let value):
                let cell: MeChatCell = tableView.dequeueReusableCell(for: indexPath)
                cell.set(title: value)
                return cell
            case .other(let value):
                let cell: OtherChatCell = tableView.dequeueReusableCell(for: indexPath)
                cell.set(title: value)
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension ChatVC {
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
            viewBottomConstraint: self.bottomConstraint,
            keyboardWillShow: false
        )
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        moveViewWithKeyboard(
            notification: notification,
            viewBottomConstraint: self.bottomConstraint,
            keyboardWillShow: true
        )
    }
}
