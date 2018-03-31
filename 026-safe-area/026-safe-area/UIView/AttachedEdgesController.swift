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
        
        let topSubview = CustomView()
        let bottomSubview = CustomView()
        
        view.addSubview(topSubview)
        view.addSubview(bottomSubview)
        
        topSubview.frame = CGRect(x: 0, y: 0, width: screenW, height: 200)
        bottomSubview.frame = CGRect(x: 0, y: screenH - 200, width: screenW, height: 200)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        topSubview.addGestureRecognizer(tap)
        topSubview.isUserInteractionEnabled = true
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}
