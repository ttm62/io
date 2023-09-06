//
//  PeriodView.swift
//  io
//
//  Created by davidtam on 06/09/2023.
//

import UIKit

enum PeriodType {
    case top
    case middle
    case bottom
}

final
class PeriodView: UIView, NibLoadableView {
    
    @IBOutlet weak var topDash: UIStackView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var bottomDash: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    func config(period: PeriodType, title: String, icon: String) {
        self.titleLabel.text = title
        self.iconImage.image = UIImage(named: icon)
        
        switch period {
        case .top:
            topDash.isHidden = true
        case .middle:
            topDash.isHidden = false
        case .bottom:
            topDash.isHidden = false
        }
        
        switch period {
        case .top:
            bottomDash.isHidden = false
        case .middle:
            bottomDash.isHidden = false
        case .bottom:
            bottomDash.isHidden = true
        }
    }
}
