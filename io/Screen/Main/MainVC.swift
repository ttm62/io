//
//  MainVC.swift
//  io
//
//  Created by gv on 11/08/2023.
//

import UIKit
import Flutter
import ContactsUI
import AVFoundation

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
        if let engine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine {
            let flutterVC = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
            self.navigationController?.present(flutterVC, animated: true)
        }
    }
    
    @IBAction
    func didTapStretchy() {
        let stretchyVC = StretchyVC.loadFromNib()
        self.navigationController?.pushViewController(stretchyVC, animated: true)
    }
    
    @IBAction
    func didTapMap() {
        let mapVC = MapVC.loadFromNib()
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @IBAction
    func didTapMediumSheet() {
        let setTimeVC = SetTimeForRide.loadFromNib()
        present(
            setTimeVC.with {
                $0.preferredSheetSizing = .large
            },
            animated: true
        )
    }
    
    @IBAction
    func didTapChat() {
        let chatVC = ChatVC.loadFromNib()
        push(controller: chatVC)
    }
    
    @IBAction
    func didTapCustomView() {
        let viewsVC = CustomViewsVC.loadFromNib()
        push(controller: viewsVC)
    }
    
    @IBAction
    func didTapContacts() {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction
    func didTapCustomFont() {
        let fontVC = FontVC.loadFromNib()
        push(controller: fontVC)
    }
    
    @IBAction
    func didTapDashedLine() {
        let dashedLineVC = DashedLineVC.loadFromNib()
        push(controller: dashedLineVC)
    }
    
    @IBAction
    func didTapPlaySound() {
        audioPlayer?.play()
    }
    
    @IBAction
    func didTapSelectVehicle() {
        let selectVC = SelectVehicle.loadFromNib()
        push(controller: selectVC)
    }
    
    @IBAction
    func didTapDestination() {
        let destinationVC = DestinationVC.loadFromNib()
        push(controller: destinationVC)
    }
    
    var audioPlayer: AVAudioPlayer?

    func setupAudioPlayer() {
        if let soundURL = Bundle.main.url(forResource: "huy_chuyen", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error loading sound: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Print all fonts
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
         */
        
        setupAudioPlayer()
        
    }
}

extension MainVC: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print(contact)
    }
}

