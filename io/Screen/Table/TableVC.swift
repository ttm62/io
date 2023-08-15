//
//  TableVC.swift
//  io
//
//  Created by gv on 11/08/2023.
//

import UIKit

class TableVC: UIViewController {

    @IBOutlet weak var sampleTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleTable.dataSource = self
        sampleTable.delegate = self
        
        sampleTable.register(SampleCell.self)
        sampleTable.register(PagesCell.self)
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
            return 60
        }
    }
}
