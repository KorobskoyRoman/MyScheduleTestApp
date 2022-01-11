//
//  AppDelegate.swift
//  MyScheduleTestApp
//
//  Created by Roman Korobskoy on 11.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navBar = UINavigationController()
        let mainView = MainViewController(nibName: nil, bundle: nil)
        navBar.viewControllers = [mainView]
        window?.rootViewController = navBar
        window?.makeKeyAndVisible()
        
        return true
    }
}

