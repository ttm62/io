//
//  SelfSizingTable.swift
//  io
//
//  Created by gv on 15/08/2023.
//

import UIKit

class SelfSizingTableView: UITableView {
    var maxHeight: CGFloat = .infinity
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(maxHeight, contentSize.height)
        return CGSize(width: contentSize.width, height: height)
    }
}
