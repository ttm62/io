//
//  AppDelegate.swift
//  io
//
//  Created by gv on 11/08/2023.
//

import UIKit
import Flutter
import FlutterPluginRegistrant
import GoogleMaps

@main
class AppDelegate: FlutterAppDelegate {
    
    // var window: UIWindow?
    var navigation: UINavigationController?
    lazy var flutterEngine = FlutterEngine(name: "my flutter engine")
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Config
        GMSServices.provideAPIKey("AIzaSyDWsMvDeOaou3X1aRSnXEIUVlymkzVkCgA")
        
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        navigation = UINavigationController(rootViewController: MainVC.loadFromNib())
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        // flutter init
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: self.flutterEngine)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
