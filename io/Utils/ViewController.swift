//
//  ViewController.swift
//  io
//
//  Created by gv on 11/08/2023.
//

import Foundation
import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: Bundle(for: self))
        }
        
        return instantiateFromNib()
    }
}

extension UIView {
    func loadFromNib() {
        let name = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        guard let view = bundle.loadNibNamed(name, owner: self, options: nil)?.first as? UIView else {
            fatalError("Nib not found.")
        }
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        layoutAttachViewToSuperview(view: view)
    }
    
    func layoutAttachViewToSuperview(view: UIView) {
        let views = ["view" : view]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                 options: [],
                                                                 metrics: nil,
                                                                 views: views)
        addConstraints(horizontalConstraints + verticalConstraints)
    }
}
