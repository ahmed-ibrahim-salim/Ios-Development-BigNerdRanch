//
//  AppDelegate.swift
//  BigNerdRanchProjects
//
//  Created by ahmed ibrahim on 22/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let itemStore = ItemStore()
        let navigationController = window!.rootViewController as! UINavigationController
        let vc = navigationController.topViewController as!     ItemsViewController
        vc.itemStore = itemStore
        return true
    }
}

