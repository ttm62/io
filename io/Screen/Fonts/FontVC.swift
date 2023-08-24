//
//  FontVC.swift
//  io
//
//  Created by gv on 24/08/2023.
//

import UIKit

class FontVC: UIViewController {
    
    @IBOutlet weak var largeTitle: UILabel!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var callout: UILabel!
    @IBOutlet weak var subheadline: UILabel!
    @IBOutlet weak var footnote: UILabel!
    @IBOutlet weak var caption1: UILabel!
    @IBOutlet weak var caption2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        largeTitle.font = .customFont(NunitoSans.black, forTextStyle: .body)
//        title1.font = .customFont(NunitoSans.blackitalic, forTextStyle: .body)
//        title2.font = .customFont(NunitoSans.bold, forTextStyle: .body)
//        title3.font = .customFont(NunitoSans.bolditalic, forTextStyle: .body)
//        headline.font = .customFont(NunitoSans.extraBold, forTextStyle: .body)
//        body.font = .customFont(NunitoSans.extraBolditalic, forTextStyle: .body)
//        callout.font = .customFont(NunitoSans.extraLight, forTextStyle: .body)
//        subheadline.font = .customFont(NunitoSans.extraLightitalic, forTextStyle: .body)
//        footnote.font = .customFont(NunitoSans.italic, forTextStyle: .body)
//        caption1.font = .customFont(NunitoSans.light, forTextStyle: .body)
//        caption2.font = .customFont(NunitoSans.lightitalic, forTextStyle: .body)
        
        largeTitle.text = "largeTitle"
        title1.text = "title1"
        title2.text = "title2"
        title3.text = "title3"
        headline.text = "headline"
        body.text = "body"
        callout.text = "callout"
        subheadline.text = "subheadline"
        footnote.text = "footnote"
        caption1.text = "caption1"
        caption2.text = "caption2"
    }
}

// MARK: Config
protocol DynamicFont {
    func fontName() -> String
    func fontSize(style: UIFont.TextStyle) -> CGFloat
}

extension UIFont {
    static func customFont(
        _ font: DynamicFont,
        forTextStyle style: UIFont.TextStyle,
        overrideFontSize: UIContentSizeCategory? = nil
    ) -> UIFont? {
        guard let customFont = UIFont(name: font.fontName(), size: font.fontSize(style: style)) else { return nil }
        
        let metrics = UIFontMetrics(forTextStyle: style)
        let scaledFont: UIFont = metrics.scaledFont(
            for: customFont, compatibleWith: UITraitCollection(
                preferredContentSizeCategory: overrideFontSize ?? .unspecified
            )
        )
        
        return scaledFont
    }
}

// MARK: Custom font
enum NunitoSans: DynamicFont {
    case black
    case blackitalic
    case bold
    case bolditalic
    case extraBold
    case extraBolditalic
    case extraLight
    case extraLightitalic
    case italic
    case light
    case lightitalic
    case medium
    case mediumItalic
    case regular
    case semiBold
    case semiBolditalic
    
    func fontName() -> String {
        switch self {
        case .black: return "NunitoSans_10pt-Black.ttf"
        case .blackitalic: return "NunitoSans_10pt-Blackitalic.ttf"
        case .bold: return "NunitoSans_10pt-Bold.ttf"
        case .bolditalic: return "NunitoSans_10pt-Bolditalic.ttf"
        case .extraBold: return "NunitoSans_10pt-ExtraBold.ttf"
        case .extraBolditalic: return "NunitoSans_10pt-ExtraBolditalic.ttf"
        case .extraLight: return "NunitoSans_10pt-ExtraLight.ttf"
        case .extraLightitalic: return "NunitoSans_10pt-ExtraLightitalic.ttf"
        case .italic: return "NunitoSans_10pt-Italic.ttf"
        case .light: return "NunitoSans_10pt-Light.ttf"
        case .lightitalic: return "NunitoSans_10pt-Lightitalic.ttf"
        case .medium: return "NunitoSans_10pt-Medium.ttf"
        case .mediumItalic: return "NunitoSans_10pt-MediumItalic.ttf"
        case .regular: return "NunitoSans_10pt-Regular.ttf"
        case .semiBold: return "NunitoSans_10pt-SemiBold.ttf"
        case .semiBolditalic: return "NunitoSans_10pt-SemiBolditalic.ttf"
        }
    }
    
    func fontSize(style: UIFont.TextStyle) -> CGFloat {
        switch style {
        case .largeTitle: return 34.0
        case .title1: return 28.0
        case .title2: return 22.0
        case .title3: return 20.0
        case .headline: return 18.0
        case .body: return 17.0
        case .callout: return 16.0
        case .subheadline: return 15.0
        case .footnote: return 13.0
        case .caption1: return 12.0
        case .caption2: return 11.0
        default: return 17.0
        }
    }
}
