//
//  ChatCell.swift
//  io
//
//  Created by gv on 23/08/2023.
//

import UIKit

enum ChatContent {
    case other(String)
    case me(String)
}

class ChatCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var leftPadding: NSLayoutConstraint!
    @IBOutlet weak var rightPadding: NSLayoutConstraint!
    
    func set(content: ChatContent?) {
//        containerView.backgroundColor = .randomColor()
        
        // config for message from myself
        if case .me(let title) = content {
            contentLabel.text = title
            contentLabel.textColor = .white
            
            leftPadding.constant = 60
            rightPadding.constant = 10
            
            // reset
            bubbleView.backgroundColor = UIColor(red: 0.3, green: 0.43, blue: 0.74, alpha: 1)
            bubbleView.roundCorners(corners: [.allCorners], radius: 0)
            bubbleView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 16)
        }
        
        // config for message from other
        if case .other(let title) = content {
            contentLabel.text = title
            contentLabel.textColor = .black
            
            leftPadding.constant = 10
            rightPadding.constant = 60
            
            // reset
            bubbleView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 1, alpha: 1)
            bubbleView.roundCorners(corners: [.allCorners], radius: 0)
            bubbleView.roundCorners(corners: [.topLeft, .topRight, .bottomRight], radius: 10)
        }
    }
}
