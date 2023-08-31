//
//  CustomViewsVC.swift
//  io
//
//  Created by gv on 23/08/2023.
//

import UIKit

class CustomViewsVC: UIViewController {

    @IBOutlet weak var inputField: GVInput!
    
    @IBAction func didTapEnable(_ sender: Any) {
        inputField.shouldDisable = false
    }
    
    @IBAction func didTapError(_ sender: Any) {
        inputField.shouldDisable = false
    }
    
    @IBAction func didTapDisable(_ sender: Any) {
        inputField.shouldDisable = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputField.validator = { value in
            return value ~= "[a-z]at"
        }
        
        inputField.rightIconAction = {
            print("...")
        }
        
        // what to do after dismiss keyboard?
        self.view.addGestureRecognizer(UITapGestureRecognizer { [weak self] _ in
            self?.dismissKeyboard()
            
//            inputField.
        })
    }
}
