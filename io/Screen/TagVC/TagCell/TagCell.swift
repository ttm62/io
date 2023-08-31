//
//  TagCell.swift
//  io
//
//  Created by gv on 31/08/2023.
//

import UIKit

final
class TagCell: UICollectionViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func wasSelected() {
        container.backgroundColor = .primary01
        container.cornerRadius = 16
        icon.tintColor = .primary07
        title.textColor = .primary07
        self.setNeedsLayout()
    }
    
    func wasntSelected() {
        container.backgroundColor = .primary07
        container.cornerRadius = 16
        icon.tintColor = .white
        title.textColor = .white
        self.setNeedsLayout()
    }
}

// MARK: LAYOUT
class Row {
    var attributes = [UICollectionViewLayoutAttributes]()
    var spacing: CGFloat = 0

    init(spacing: CGFloat) {
        self.spacing = spacing
    }

    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }

    func tagLayout(collectionViewWidth: CGFloat) {
        let padding = 6
        var offset = padding
        for attribute in attributes {
            attribute.frame.origin.x = CGFloat(offset)
            offset += Int(attribute.frame.width + spacing)
        }
    }
}

class TagFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        var rows = [Row]()
        var currentRowY: CGFloat = -1

        for attribute in attributes {
            if currentRowY != attribute.frame.origin.y {
                currentRowY = attribute.frame.origin.y
                rows.append(Row(spacing: 6))
            }
            rows.last?.add(attribute: attribute)
        }

        rows.forEach {
            $0.tagLayout(collectionViewWidth: collectionView?.frame.width ?? 0)
        }
        return rows.flatMap { $0.attributes }
    }
}
