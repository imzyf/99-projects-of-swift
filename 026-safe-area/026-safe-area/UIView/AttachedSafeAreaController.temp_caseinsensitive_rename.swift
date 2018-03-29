//
//  AttachedSafeareaControllerViewController.swift
//  026-safe-area
//
//  Created by  moma on 2018/3/29.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

class AttachedSafeAreaController: UIViewController {

    let topSubview = CustomView()
    let bottomSubview = CustomView()
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        view.addSubview(topSubview)
        view.addSubview(bottomSubview)
        view.backgroundColor = .lightGray
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if #available(iOS 11.0, *) {
            topSubview.frame.origin.x = view.safeAreaInsets.left
            topSubview.frame.origin.y = view.safeAreaInsets.top
            topSubview.frame.size.width = view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right
            topSubview.frame.size.height = 200
        
            bottomSubview.translatesAutoresizingMaskIntoConstraints = false
            bottomSubview.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
            bottomSubview.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
            bottomSubview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            bottomSubview.heightAnchor.constraint(equalToConstant: 200).isActive = true
        } else {
            
        }
    }
}
