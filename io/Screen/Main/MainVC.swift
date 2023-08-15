//
//  MainVC.swift
//  io
//
//  Created by gv on 11/08/2023.
//

import UIKit

final
class MainVC: UIViewController {
    
    @IBAction 
    func didTapOpenTable(_ sender: UIButton) {
        let tableVC = TableVC.loadFromNib()
        self.navigationController?.pushViewController(tableVC, animated: true)
    }
    
    @IBAction
    func didTapOpenOTP(_ sender: UIButton) {
        let otpVC = OtpVC.loadFromNib()
        self.navigationController?.pushViewController(otpVC, animated: true)
    }
    
    @IBAction
    func didTapOpenFlutter(_ sender: UIButton) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = "Demo"
    }
}
