//
//  TableVC.swift
//  io
//
//  Created by gv on 11/08/2023.
//

import UIKit

class TableVC: UIViewController {

    @IBOutlet weak var sampleTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleTable.dataSource = self
        sampleTable.delegate = self
        
        sampleTable.register(SampleCell.self)
        sampleTable.register(PagesCell.self)
        sampleTable.register(RecommendGrid.self)
        
        let headerView = StretchyTableHeaderView(
            frame: .init(x: 0, y: 0, width: self.view.bounds.width, height: 300)
        )
        
        // Image from unsplash: https://unsplash.com/photos/iVPWGCbFwd8
        headerView.imageView.image = UIImage(named: "header")
        self.sampleTable.tableHeaderView = headerView
        
        sampleTable.rowHeight = UITableView.automaticDimension
    }
}

extension TableVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.sampleTable.tableHeaderView as! StretchyTableHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }
}

extension TableVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: PagesCell = tableView.dequeueReusableCell(for: indexPath)
            
            return cell
            
        case 9:
            let cell: RecommendGrid = tableView.dequeueReusableCell(for: indexPath)
            return cell
            
        default:
            let cell: SampleCell = tableView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = "\(indexPath.row)"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
}

