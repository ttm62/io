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
    }
}

extension TableVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SampleCell = tableView.dequeueReusableCell(for: indexPath)
        cell.titleLabel.text = "\(indexPath.row)"
        
        return cell
    }
}
