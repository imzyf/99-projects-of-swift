//
//  LabelAttachedSafeAreaController.swift
//  026-safe-area
//
//  Created by  moma on 2018/3/29.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

class LabelAttachedEdgesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topView = LabelCustomView()
        let bottomView = LabelCustomView()
        
        view.addSubview(topView)
        view.addSubview(bottomView)
        
        topView.frame = CGRect(x: 0, y: 0, width: screenW, height: 200)
        bottomView.frame = CGRect(x: 0, y: screenH - 200, width: screenW, height: 200)
    }
}
