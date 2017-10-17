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
    var timer: Timer!
    var time = 0.0
    var startButton: UIButton!
 
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
        resetButton.addTarget(self, action: #selector(resetAction), for: .touchUpInside)
        
        // 计时 Label
        timeLabel = UILabel()
        self.view.addSubview(timeLabel)
        timeLabel.text = "00:00.0"
        timeLabel.font = UIFont.systemFont(ofSize: 40)
        timeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view.frame.height/4)
        }
        
        // start
        startButton = UIButton()
        self.view.addSubview(startButton)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor(red: 1, green: 101/255.0, blue: 27/255.0, alpha: 1)
        startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        startButton.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(0)
            make.width.equalTo(self.view.frame.width/2)
            make.height.equalTo(self.view.frame.height/2)
        }
        
        // end - 直接添加 button
        let endButton = UIButton()
        self.view.addSubview(endButton)
        endButton.setTitle("Stop", for: .normal)
        endButton.setTitleColor(.white, for: .normal)
        endButton.backgroundColor = UIColor(red: 98/255.0, green: 242/255.0, blue: 23/255.0, alpha: 1)
        endButton.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(0)
            make.size.equalTo(startButton)
        }
        endButton.addTarget(self, action: #selector(stopAction), for: .touchUpInside)
        
    }
    
    @objc func startAction() {
        if startButton.isEnabled {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
                self.time += 0.1
                self.timeLabel.text = self.time2String(time: self.time)
            })
            self.timer.fire()
            startButton.isEnabled = false
            startButton.setTitle("Running", for: .normal)
        }
    }
    
    @objc func stopAction() {
        guard let timerForDistory = self.timer
            else {return}
        timerForDistory.invalidate()
        startButton.isEnabled = true
        startButton.setTitle("Resume", for: .normal)
    }
    
    @objc func resetAction() {
        stopAction()
        self.time = 0.0
        self.timeLabel.text = "00:00.0"
        startButton.setTitle("Start", for: .normal)
    }
    
    func time2String(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        let milliseconds = Int(time*10) % 10
        return String(format:"%02i:%02i.%01i", minutes, seconds, milliseconds)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

