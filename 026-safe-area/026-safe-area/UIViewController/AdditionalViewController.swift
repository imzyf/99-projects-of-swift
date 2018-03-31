//
//  AdditionalViewController.swift
//  026-safe-area
//
//  Created by  moma on 2018/3/29.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

class AdditionalViewController: UIViewController {
    
    let topSubview = LabelCustomView()
    let bottomSubview = LabelCustomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(topSubview)
        view.addSubview(bottomSubview)
        
        topSubview.frame = CGRect(x: 0, y: 0, width: screenW, height: 200)
        bottomSubview.frame = CGRect(x: 0, y: screenH - 200, width: screenW, height: 200)
        
        statusBarHidden = true
        
        if #available(iOS 11.0, *) {
            additionalSafeAreaInsets.top = 20
            additionalSafeAreaInsets.left = 20
            additionalSafeAreaInsets.right = 20
            additionalSafeAreaInsets.bottom = 20
        } else {
            // Fallback on earlier versions
        }
    }
    
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        print("-- called viewSafeAreaInsetsDidChange")
    }
    
    var statusBarHidden = false {
        didSet {
            UIView.animate(withDuration: 0.4) { () -> Void in
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}
