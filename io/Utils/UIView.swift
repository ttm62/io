//
//  UIView.swift
//  io
//
//  Created by gv on 14/08/2023.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var cornerRadiusValue: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}
