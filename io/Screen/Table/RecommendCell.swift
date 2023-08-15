//
//  RecommendCell.swift
//  io
//
//  Created by gv on 15/08/2023.
//

import UIKit

class RecommendCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var recommendGrid: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recommendGrid.register(RecommendGridCell.self)
        recommendGrid.delegate = self
        recommendGrid.dataSource = self
        

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        recommendGrid.setCollectionViewLayout(layout, animated: true)
    }
}

extension RecommendCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
