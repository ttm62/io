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
    static var neutral01: UIColor = .init(hex: "#F4F4FF") ?? .clear
    static var neutral02: UIColor = .init(hex: "#E2E2F1") ?? .clear
    static var neutral03: UIColor = .init(hex: "#СВСВЕ4") ?? .clear
    static var neutral04: UIColor = .init(hex: "#B1B1D0") ?? .clear
    static var neutral05: UIColor = .init(hex: "#9B9BB9") ?? .clear
    static var neutral06: UIColor = .init(hex: "#8585A3") ?? .clear
    static var neutral07: UIColor = .init(hex: "#70708C") ?? .clear
    static var neutral08: UIColor = .init(hex: "#5C5C75") ?? .clear
    static var neutral09: UIColor = .init(hex: "#48485F") ?? .clear
    static var neutral10: UIColor = .init(hex: "#363648") ?? .clear
    static var neutral11: UIColor = .init(hex: "#252532") ?? .clear
    
    static var blue01: UIColor = .init(hex: "#EEFAFF") ?? .clear
    static var blue02: UIColor = .init(hex: "#CCF1FF") ?? .clear
    static var blue03: UIColor = .init(hex: "#99DEFF") ?? .clear
    static var blue04: UIColor = .init(hex: "#66C5FF") ?? .clear
    static var blue05: UIColor = .init(hex: "#3FADFF") ?? .clear
    static var blue06: UIColor = .init(hex: "#0085FF") ?? .clear
    static var blue07: UIColor = .init(hex: "#0066DB") ?? .clear
    static var blue08: UIColor = .init(hex: "#004CB7") ?? .clear
    static var blue09: UIColor = .init(hex: "#003693") ?? .clear
    static var blue10: UIColor = .init(hex: "#00267A") ?? .clear
    static var blue11: UIColor = .init(hex: "#001645") ?? .clear
    
    static var gray01: UIColor = .init(hex: "#FBFBFB") ?? .clear
    static var gray02: UIColor = .init(hex: "#EZEZE7") ?? .clear
    static var gray03: UIColor = .init(hex: "#D3D3D3") ?? .clear
    static var gray04: UIColor = .init(hex: "#ВЕВЕВЕ") ?? .clear
    static var gray05: UIColor = .init(hex: "#AAAAAA") ?? .clear
    static var gray06: UIColor = .init(hex: "#959595") ?? .clear
    static var gray07: UIColor = .init(hex: "#818181") ?? .clear
    static var gray08: UIColor = .init(hex: "#6D6B6B") ?? .clear
    static var gray09: UIColor = .init(hex: "#585555") ?? .clear
    static var gray10: UIColor = .init(hex: "#444040") ?? .clear
    static var gray11: UIColor = .init(hex: "#242424") ?? .clear
    
    static var red01: UIColor = .init(hex:"#FFE9E9") ?? .clear
    static var red02: UIColor = .init(hex:"#FEC3C3") ?? .clear
    static var red03: UIColor = .init(hex:"#FF8686") ?? .clear
    static var red04: UIColor = .init(hex:"#FF6363") ?? .clear
    static var red05: UIColor = .init(hex:"#FF3838") ?? .clear
    static var red06: UIColor = .init(hex:"#FFOAOA") ?? .clear
    static var red07: UIColor = .init(hex:"#DB0707") ?? .clear
    static var red08: UIColor = .init(hex:"#B70505") ?? .clear
    static var red09: UIColor = .init(hex:"#930303") ?? .clear
    static var red10: UIColor = .init(hex:"#7A0101") ?? .clear
    static var red11: UIColor = .init(hex:"#5C0011") ?? .clear
    
    static var primary01: UIColor = .init(hex: "#F2F6FF") ?? .clear
    static var primary02: UIColor = .init(hex: "#D7E2FF") ?? .clear
    static var primary03: UIColor = .init(hex: "#BBCEFF") ?? .clear
    static var primary04: UIColor = .init(hex: "#9FBAFF") ?? .clear
    static var primary05: UIColor = .init(hex: "#83A6FF") ?? .clear
    static var primary06: UIColor = .init(hex: "#6789DF") ?? .clear
    static var primary07: UIColor = .init(hex: "#4D6CBD") ?? .clear
    static var primary08: UIColor = .init(hex: "#37539B") ?? .clear
    static var primary09: UIColor = .init(hex: "#243C79") ?? .clear
    static var primary10: UIColor = .init(hex: "#162857") ?? .clear
    static var primary11: UIColor = .init(hex: "#000E31") ?? .clear
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
