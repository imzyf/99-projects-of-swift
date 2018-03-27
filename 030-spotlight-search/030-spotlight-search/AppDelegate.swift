//
//  AppDelegate.swift
//  030-spotlight-search
//
//  Created by  moma on 2018/3/27.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
 
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        let identifier = userActivity.userInfo?["kCSSearchableItemActivityIdentifier"] as! String
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: ["id": identifier])
        return true
    }
}
