//
//  GVInput.swift
//  io
//
//  Created by gv on 23/08/2023.
//

import UIKit

enum GVInputType {
    case disable
    case normal
    case editing
    case error(String)
}

@IBDesignable
final class GVInput: UIView, NibLoadableView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var hintLabel: UILabel!
    
    var stateValue: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }
    
    private func prepare() {
        loadViewFromNib()
    }
}

extension GVInput {
    @IBInspectable var state: CGFloat {
        get {
            return stateValue
        }
        set(value) {
            switch value {
            case 0: // disable
                titleLabel.tintColor = UIColor(red: 0.96, green: 0.96, blue: 1, alpha: 1)
                searchView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 1, alpha: 1)
                hintLabel.textColor = UIColor(red: 0.96, green: 0.96, blue: 1, alpha: 1)
            case 1: // normal
                titleLabel.tintColor = UIColor(red: 0.21, green: 0.21, blue: 0.28, alpha: 1)
                searchView.backgroundColor = .clear
                hintLabel.textColor = UIColor(red: 0.52, green: 0.52, blue: 0.64, alpha: 1)
                searchViewBorderColor = UIColor(red: 0.8, green: 0.8, blue: 0.89, alpha: 1).cgColor
//            case 2:
//                
//            case 3:
//            case 4:
            default:
                titleLabel.tintColor = UIColor(red: 0.21, green: 0.21, blue: 0.28, alpha: 1)
                searchView.backgroundColor = .clear
                hintLabel.textColor = UIColor(red: 0.52, green: 0.52, blue: 0.64, alpha: 1)
                searchViewBorderColor = UIColor(red: 0.8, green: 0.8, blue: 0.89, alpha: 1).cgColor
            }
        }
    }
    
    @IBInspectable var searchViewBorderColor: CGColor? {
        get {
            return searchView.layer.borderColor
        }
        set(value) {
            searchView.layer.borderWidth = 1
            searchView.layer.borderColor = value
        }
    }
}
