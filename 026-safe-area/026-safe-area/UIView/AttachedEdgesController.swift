//
//  ViewController.swift
//  026-safe-area
//
//  Created by  moma on 2018/3/6.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

let screenW = UIScreen.main.bounds.size.width
let screenH = UIScreen.main.bounds.size.height

class AttachedEdgesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topView = CustomView()
        let bottomView = CustomView()
        
        view.addSubview(topView)
        view.addSubview(bottomView)
        
        topView.frame = CGRect(x: 0, y: 0, width: screenW, height: 200)
        bottomView.frame = CGRect(x: 0, y: screenH - 200, width: screenW, height: 200)
    }
}
