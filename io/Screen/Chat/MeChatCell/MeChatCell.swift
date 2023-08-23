//
//  MeChatCell.swift
//  io
//
//  Created by gv on 23/08/2023.
//

import UIKit

class MeChatCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var leftPadding: NSLayoutConstraint!
    @IBOutlet weak var rightPadding: NSLayoutConstraint!
    
    override func layoutSubviews() {
        // Initialization code
        titleButton.tintColor = .white
        
        leftPadding.constant = 60
        rightPadding.constant = 10
        
        // reset
        titleButton.backgroundColor = UIColor(red: 0.3, green: 0.43, blue: 0.74, alpha: 1)
//        bubbleView.roundCorners(corners: [.allCorners], radius: 0)
        titleButton.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 10)
    }
    
    func set(title: String) {
        titleButton.setTitle(title, for: .normal)
    }
}
