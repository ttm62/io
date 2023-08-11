//
//  AppDelegate.swift
//  io
//
//  Created by gv on 11/08/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigation: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        navigation = UINavigationController(rootViewController: MainVC.loadFromNib())
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}

