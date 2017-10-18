//
//  ViewController.swift
//  007-meun-botton-animation
//
//  Created by  moma on 2017/10/17.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let animationView = ChangeAnimationView(frame: self.view.frame)
        animationView.frame.size.height = 100 + 8 * 2
        animationView.center = self.view.center
        self.view.addSubview(animationView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

