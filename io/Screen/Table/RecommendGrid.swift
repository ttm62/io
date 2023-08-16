//
//  RecommendCell.swift
//  io
//
//  Created by gv on 15/08/2023.
//

import UIKit

class DynamicCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
}

class RecommendGrid: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var recommendGrid: DynamicCollectionView!
    
    var layout: UICollectionViewFlowLayout = {
        // Flow layout
        let screenWidth = UIScreen.main.bounds.width - 20
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = .init(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = .init(width: screenWidth/3, height: (screenWidth/3)*5/4)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        return layout
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recommendGrid.register(RecommendGridCell.self)
        recommendGrid.delegate = self
        recommendGrid.dataSource = self

        recommendGrid.setCollectionViewLayout(layout, animated: true)
        
//        var height = self.recommendGrid.collectionViewLayout.collectionViewContentSize.height
//        recommendGrid.frame.height = height
//        recommendGrid.layoutIfNeeded()
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return self.recommendGrid.contentSize
    }
}

extension RecommendGrid: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 120
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecommendGridCell = collectionView.dequeueReusableCell(for: indexPath)
        
        cell.backgroundColor = .randomColor()
        return cell
    }
    
    
}

// ====

/// Extension for random value get.
extension CGFloat {
    static func randomValue() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
/// Extension for random color using random value.
extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(
           red:   .randomValue(),
           green: .randomValue(),
           blue:  .randomValue(),
           alpha: 1.0
        )
    }
}
