//
//  TagListView.swift
//  io
//
//  Created by gv on 31/08/2023.
//

import UIKit

final
class TagListView: UIView, NibLoadableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }
    
    func prepare() {
        loadViewFromNib()
    }
}
