//
//  StretchyVC.swift
//  io
//
//  Created by gv on 21/08/2023.
//

import UIKit

class StretchyVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SampleCell.self)
    }
    
    
}

extension StretchyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sampleCell: SampleCell = tableView.dequeueReusableCell(for: indexPath)
        sampleCell.titleLabel.text = "row \(indexPath.row)"
        return sampleCell
    }
}

