//
//  ViewController.swift
//  001-scroll-card
//
//  Created by  yifan on 2017/9/24.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        createRootView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createRootView() {
        let layout = CustomLayout()
        layout.itemSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        
        let rect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        
        view.addSubview(collectionView)
    }


}

