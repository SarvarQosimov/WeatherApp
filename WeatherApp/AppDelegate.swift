//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Sarvar Qosimov on 20/02/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController  = MainVC()
        window?.makeKeyAndVisible()
        return true
    }

    

}

