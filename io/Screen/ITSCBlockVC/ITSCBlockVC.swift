//
//  ITSCBlockVC.swift
//  io
//
//  Created by gv on 31/08/2023.
//

import UIKit
import RichString

class ITSCBlockVC: UIViewController {
    @IBOutlet weak var block1: ITSCBlock!
    @IBOutlet weak var block2: ITSCBlock!
    @IBOutlet weak var block3: ITSCBlock!
    @IBOutlet weak var block4: ITSCBlock!
    @IBOutlet weak var block5: ITSCBlock!
    @IBOutlet weak var block6: ITSCBlock!
    @IBOutlet weak var block7: ITSCBlock!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        block1.with {
            $0.leftImage.image = UIImage.init(systemName: "house")
            $0.titleContent = "B1 title".color(.blue)
            $0.didTapTitleAction = { print(".") }
        }.inspect
        
        block2.with {
            $0.leftImage.image = UIImage.init(systemName: "house")
            $0.leftViewAlignment = .center
            $0.titleContent = "B2 title".fontSize(20)
            $0.subtitleContent = "B2 subtitle".backgroundColor(.green)
            $0.imageStackSpacing = 20
        }.inspect
        
        block3.with {
            $0.leftImage.image = UIImage.init(systemName: "arrow.left")
            $0.leftViewAlignment = .bottom
            $0.textStackSpacing = 20
        }.inspect
    }
}
