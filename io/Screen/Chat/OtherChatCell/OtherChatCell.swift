//
//  OtherChatCell.swift
//  io
//
//  Created by gv on 23/08/2023.
//

import UIKit

class OtherChatCell: UITableViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var leftPadding: NSLayoutConstraint!
    @IBOutlet weak var rightPadding: NSLayoutConstraint!
    
    override func layoutSubviews() {
        // Initialization code
        titleButton.tintColor = .black
        
        leftPadding.constant = 10
        rightPadding.constant = 60
        
        // reset
        titleButton.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 1, alpha: 1)
//        bubbleView.roundCorners(corners: [.allCorners], radius: 0)
        titleButton.roundCorners(corners: [.topLeft, .topRight, .bottomRight], radius: 10)
    }
    
    func set(title: String) {
        titleButton.setTitle(title, for: .normal)
    }
}
