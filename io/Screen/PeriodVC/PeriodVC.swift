//
//  PeriodVC.swift
//  io
//
//  Created by davidtam on 06/09/2023.
//

import UIKit

final
class PeriodVC: UIViewController {
    @IBOutlet weak var topPeriod: PeriodView!
    @IBOutlet weak var midPeriod: PeriodView!
    @IBOutlet weak var botPeriod: PeriodView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topPeriod.config(period: .top, title: "top", icon: "gv_pin")
        midPeriod.config(period: .middle, title: "mid", icon: "gv_pin")
        botPeriod.config(period: .bottom, title: "bot", icon: "gv_location")
    }
}
