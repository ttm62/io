//
//  UILabel+Extensions.swift
//  Withable
//
//  Created by Geri Borbás on 08/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


public extension UILabel {
    
    func with(text: String?) -> Self {
        with {
            $0.text = text
        }
    }
    
    func withTextColor(_ color: UIColor?) -> Self {
        with {
            $0.textColor = color
        }
    }
    
    func withFont(_ font: UIFont?) -> Self {
        with {
            $0.font = font
        }
    }
}
