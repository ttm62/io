//
//  TagVC.swift
//  io
//
//  Created by gv on 31/08/2023.
//

import UIKit

class TagVC: UIViewController {

    @IBOutlet weak var tagCollection: UICollectionView!
    
    var tags: [String] = [
        "America",
        "Vietnam",
        "Bangladesh",
        "China",
        "Denmark",
        "Egypt",
        "Finland Finland",
        "Germany 123",
        "Holand",
        "Italy",
        "Japan"
    ]
    
    var selected: [Int] = [
        1, 2, 4
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagCollection.delegate = self
        tagCollection.dataSource = self
        let layout = TagFlowLayout()
        layout.estimatedItemSize = CGSize(width: 140, height: 40)
        tagCollection.collectionViewLayout = layout
        tagCollection.register(TagCell.self)
    }
}

extension TagVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TagCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.title.text = tags[indexPath.row]
        
        if selected.contains(indexPath.row) {
            cell.wasSelected()
        } else {
            cell.wasntSelected()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selected.contains(indexPath.row) {
            selected.removeAll {
                $0 == indexPath.row
            }
        } else {
            selected.append(indexPath.row)
        }
        
        tagCollection.reloadData()
    }
}
