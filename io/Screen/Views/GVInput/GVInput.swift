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

typealias StringValidator = (String) -> Bool

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
}

extension UIColor {
    convenience public init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

extension UIColor {
    static var neutral01: UIColor? = .init(hex: 0xF4F4FF)
    static var neutral02: UIColor? = .init(hex: 0xE2E2F1)
    static var neutral03: UIColor? = .init(hex: 0xCBCBE4)
    static var neutral04: UIColor? = .init(hex: 0xB1B1D0)
    static var neutral05: UIColor? = .init(hex: 0x9B9BB9)
    static var neutral06: UIColor? = .init(hex: 0x8585A3)
    static var neutral07: UIColor? = .init(hex: 0x70708C)
    static var neutral08: UIColor? = .init(hex: 0x5C5C75)
    static var neutral09: UIColor? = .init(hex: 0x48485F)
    static var neutral10: UIColor? = .init(hex: 0x363648)
    static var neutral11: UIColor? = .init(hex: 0x252532)
    
    static var blue01: UIColor? = .init(hex: 0xEEFAFF)
    static var blue02: UIColor? = .init(hex: 0xCCF1FF)
    static var blue03: UIColor? = .init(hex: 0x99DEFF)
    static var blue04: UIColor? = .init(hex: 0x66C5FF)
    static var blue05: UIColor? = .init(hex: 0x3FADFF)
    static var blue06: UIColor? = .init(hex: 0x0085FF)
    static var blue07: UIColor? = .init(hex: 0x0066DB)
    static var blue08: UIColor? = .init(hex: 0x004CB7)
    static var blue09: UIColor? = .init(hex: 0x003693)
    static var blue10: UIColor? = .init(hex: 0x00267A)
    static var blue11: UIColor? = .init(hex: 0x001645)
    
    static var gray01: UIColor? = .init(hex: 0xFBFBFB)
    static var gray02: UIColor? = .init(hex: 0xE7E7E7)
    static var gray03: UIColor? = .init(hex: 0xD3D3D3)
    static var gray04: UIColor? = .init(hex: 0xBEBEBE)
    static var gray05: UIColor? = .init(hex: 0xAAAAAA)
    static var gray06: UIColor? = .init(hex: 0x959595)
    static var gray07: UIColor? = .init(hex: 0x818181)
    static var gray08: UIColor? = .init(hex: 0x6D6B6B)
    static var gray09: UIColor? = .init(hex: 0x585555)
    static var gray10: UIColor? = .init(hex: 0x444040)
    static var gray11: UIColor? = .init(hex: 0x242424)
    
    static var red01: UIColor? = .init(hex: 0xFFE9E9)
    static var red02: UIColor? = .init(hex: 0xFEC3C3)
    static var red03: UIColor? = .init(hex: 0xFF8686)
    static var red04: UIColor? = .init(hex: 0xFF6363)
    static var red05: UIColor? = .init(hex: 0xFF3838)
    static var red06: UIColor? = .init(hex: 0xFF0A0A)
    static var red07: UIColor? = .init(hex: 0xDB0707)
    static var red08: UIColor? = .init(hex: 0xB70505)
    static var red09: UIColor? = .init(hex: 0x930303)
    static var red10: UIColor? = .init(hex: 0x7A0101)
    static var red11: UIColor? = .init(hex: 0x5C0011)
    
    static var primary01: UIColor? = .init(hex: 0xF2F6FF)
    static var primary02: UIColor? = .init(hex: 0xD7E2FF)
    static var primary03: UIColor? = .init(hex: 0xBBCEFF)
    static var primary04: UIColor? = .init(hex: 0x9FBAFF)
    static var primary05: UIColor? = .init(hex: 0x83A6FF)
    static var primary06: UIColor? = .init(hex: 0x6789DF)
    static var primary07: UIColor? = .init(hex: 0x4D6CBD)
    static var primary08: UIColor? = .init(hex: 0x37539B)
    static var primary09: UIColor? = .init(hex: 0x243C79)
    static var primary10: UIColor? = .init(hex: 0x162857)
    static var primary11: UIColor? = .init(hex: 0x000E31)
}

@IBDesignable
final class GVInput: UIView, NibLoadableView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var searchView: UIView!
    
    @IBOutlet private weak var leftBtn: UIButton!
    @IBInspectable var hideLeftBtn: Bool {
        get { return leftBtn.isHidden }
        set { leftBtn.isHidden = newValue }
    }
    
    @IBOutlet private weak var rightBtn: UIButton!
    @IBInspectable var hideRightBtn: Bool {
        get { return rightBtn.isHidden }
        set { rightBtn.isHidden = newValue }
    }
    
    @IBOutlet private weak var searchField: UITextField!
    
    @IBOutlet private weak var hintLabel: UILabel!
    @IBInspectable var hideHintLabel: Bool {
        get { return hintLabel.isHidden }
        set { hintLabel.isHidden = newValue }
    }
    
    // MARK: init & setup delegate
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
        searchField.addTarget(self, action: #selector(self.searchFieldDidChange), for: .editingChanged)
    }
    
    @objc func searchFieldDidChange() {
        fieldValue = searchField.text ?? ""
        print(fieldValue)
    }
    
    private var isValid: Bool = true
    var validator: StringValidator?
    var fieldValue: String {
        get { searchField.text ?? "" }
        set {
            if let validator {
                isValid = validator(newValue)
                print("validate?: \(isValid)")
            } else {
                isValid = true
                print("validate?: \(isValid)")
            }
        }
    }
    
    // MARK: Disable all view
    private var _shouldDisable: Bool = false {
        didSet {
            switch _shouldDisable {
            case true:
                ()
            default:
                ()
            }
        }
    }
    
    @IBInspectable var shouldDisable: Bool {
        get { return _shouldDisable }
        set { _shouldDisable = newValue }
    }
    
    // MARK: Action
    var rightIconAction: EmptyHandler?
    @IBAction func didTapRightIconAction() {
        rightIconAction?()
    }
}

extension GVInput: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        editingSearchViewStyle()
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        defaultSearchViewStyle()
//    }
}
