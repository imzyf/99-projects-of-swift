//
//  ViewController.swift
//  006-timer
//
//  Created by  moma on 2017/10/16.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit
import SnapKit

// 完全使用 SnapKit 布局
class ViewController: UIViewController {
    
    var timeLabel: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 224/255, green: 203/255, blue: 182/255, alpha: 1)
        
        // 重置按钮
        let resetButton = UIButton()
        self.view.addSubview(resetButton)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.right.equalTo(-30)
        }
        
        // 计时 Label
        timeLabel = UILabel()
        self.view.addSubview(timeLabel)
        timeLabel.text = "0.0"
        timeLabel.font = UIFont.systemFont(ofSize: 40)
        timeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view.frame.height/4)
        }
        
        // start
        let startView = UIView()
        self.view.addSubview(startView)
        startView.backgroundColor = UIColor(red: 1, green: 101/255.0, blue: 27/255.0, alpha: 1)
        startView.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(0)
            make.width.equalTo(self.view.frame.width/2)
            make.height.equalTo(self.view.frame.height/2)
        }
        
        let startButton = UIButton()
        startView.addSubview(startButton)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.snp.makeConstraints { (make) in
            make.center.equalTo(startView)
        }
        
        // end - 直接添加 button
        let endButton = UIButton()
        self.view.addSubview(endButton)
        endButton.setTitle("End", for: .normal)
        endButton.setTitleColor(.white, for: .normal)
        endButton.backgroundColor = UIColor(red: 98/255.0, green: 242/255.0, blue: 23/255.0, alpha: 1)
        endButton.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(0)
            make.size.equalTo(startView)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

