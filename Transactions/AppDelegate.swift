//
//  AppDelegate.swift
//  Transactions
//
//  Created by Rodrigo Gonzalez on 6/23/18.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let mainVC = ListTransactionsRouter.mainViewController()
        
        let navigationController = UINavigationController(rootViewController: mainVC)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
       
        return true
    }

}

