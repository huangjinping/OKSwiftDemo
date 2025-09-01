//
//  AppDelegate.swift
//  OSSwiftDemo
//
//  Created by 胡慧杰 on 2024/12/31.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         let viewController=ViewController()
         let nav=UINavigationController(rootViewController: viewController)
         window=UIWindow(frame: UIScreen.main.bounds)
         window?.backgroundColor=UIColor.white
         window?.rootViewController=nav
         window?.makeKeyAndVisible()
         return true
     }

}

