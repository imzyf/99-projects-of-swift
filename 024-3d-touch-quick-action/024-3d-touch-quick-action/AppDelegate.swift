//
//  AppDelegate.swift
//  024-3d-touch-quick-action
//
//  Created by  moma on 2018/2/9.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if window?.traitCollection.forceTouchCapability == .available {
            setup3DTouch(application)
        }
        
        return true
    }
    
    fileprivate func setup3DTouch(_ application: UIApplication) {
        let loveActionIcon = UIApplicationShortcutIcon(type: .love)
        let loveItem = UIApplicationShortcutItem(type: "LoveItem", localizedTitle: "Love Action", localizedSubtitle: nil, icon: loveActionIcon, userInfo: nil)
        application.shortcutItems = [loveItem]
    }
    
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ShortcutAction"), object: nil, userInfo: ["shortcutItem": shortcutItem])
    }
    
}

