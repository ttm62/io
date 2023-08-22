//
//  StretchyView.swift
//  io
//
//  Created by gv on 21/08/2023.
//

import UIKit

class StretchyView: UIView, NibLoadableView {

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
