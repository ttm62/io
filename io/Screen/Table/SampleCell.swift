//
//  SampleCell.swift
//  io
//
//  Created by gv on 11/08/2023.
//

import UIKit

final
class SampleCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
