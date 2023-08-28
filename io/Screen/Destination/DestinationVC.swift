//
//  DestinationVC.swift
//  io
//
//  Created by gv on 28/08/2023.
//

import UIKit
import GoogleMaps
import Lottie

class DestinationVC: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var placeTable: UITableView!
    
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var toField: UITextField!
    
    @IBOutlet weak var animatedLocation: AnimationView!
    
    private var bottomViewMapAnchor: NSLayoutConstraint!
    private var bottomViewListAnchor: NSLayoutConstraint!
    private var isMapView: Bool = false
    
    @IBOutlet weak var changeButtonBottomConstraint: NSLayoutConstraint!
    
    var fromCoordinate: CLLocationCoordinate2D = .init()
    var toCoordinate: CLLocationCoordinate2D = .init()
    
    override func viewWillAppear(_ animated: Bool) {
        bottomViewMapAnchor = bottomView.heightAnchor.constraint(equalToConstant: 0)
        bottomViewListAnchor = bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor)
        
        layoutListView()
        configLottieAnimation()
    }
    
    func configLottieAnimation() {
        animatedLocation.animation = Animation.named("location_drop")
        animatedLocation.loopMode = .playOnce
        animatedLocation.animationSpeed = 2
        animatedLocation.contentMode = .scaleAspectFit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp))
//        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
//        self.bottomView.addGestureRecognizer(swipeUp)

//        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(animateNextLayout))
//        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
//        self.bottomView.addGestureRecognizer(swipeDown)
        
        placeTable.delegate = self
        placeTable.dataSource = self
        placeTable.register(SampleCell.self)
        
        hideKeyboardWhenTappedAround()
        configKeyboardNotification(for: changeButtonBottomConstraint)
        
        fromField.delegate = self
        toField.delegate = self
        
        mapView.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut) {
            self.layoutListView()
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func layoutMapView() {
        isMapView = true
        view.endEditing(true)
        
        bottomViewMapAnchor.isActive = true
        bottomViewListAnchor.isActive = false
        
        self.navigationItem.rightBarButtonItem = nil
        
        topView.backgroundColor = .clear
        bottomView.layer.opacity = 0
    }
    
    @objc func layoutListView() {
        isMapView = false
        
        bottomViewMapAnchor.isActive = false
        bottomViewListAnchor.isActive = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_mapview"), style: .plain, target: self, action: #selector(animateNextLayout))
        
        topView.backgroundColor = .white
        bottomView.layer.opacity = 1
    }
    
    @objc func animateNextLayout() {
        if isMapView { // current state
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut) {
                self.layoutListView()
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut) {
                self.layoutMapView()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func didTapTopView(_ sender: Any) {
        animateNextLayout()
    }
}

extension DestinationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SampleCell = tableView.dequeueReusableCell(for: indexPath)
        cell.titleLabel.text = "row \(indexPath.row)"
        return cell
    }
}


extension DestinationVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let center = mapView.camera.target
        print(center)
        
        animatedLocation.play(toProgress: 0)
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        animatedLocation.play(toProgress: 0.5)
    }
}

extension DestinationVC {
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
            viewBottomConstraint: self.changeButtonBottomConstraint,
            keyboardWillShow: false
        )
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        moveViewWithKeyboard(
            notification: notification,
            viewBottomConstraint: self.changeButtonBottomConstraint,
            keyboardWillShow: true
        )
    }
}
