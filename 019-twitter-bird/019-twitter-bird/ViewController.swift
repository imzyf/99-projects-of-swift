//
//  ViewController.swift
//  019-twitter-bird
//
//  Created by  moma on 2017/11/18.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var twitterMask: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set up mask
        twitterMask = CALayer()
        twitterMask.contents = UIImage(named: "twitter_logo_mask")?.cgImage
        twitterMask.position = self.view.center
        twitterMask.bounds = CGRect(x: 0, y: 0, width: 100, height: 80)
 
        self.view.layer.mask = twitterMask
        
        self.animateMask()
        
    }
 
    func animateMask() {
        let anim = CAKeyframeAnimation(keyPath: "bounds")
        
        // 原始 - 变小 - 完全展开
        let startValue = twitterMask.bounds
        let middleValue = CGRect(x: 0, y: 0, width: (100*0.8), height: (80*0.8))
        let endValue = CGRect(x: 0, y: 0, width: 2000, height: 2000)
        anim.values = [startValue, middleValue, endValue]
    
        // set up time interals - 时间分配
        anim.keyTimes = [0, 0.3, 1]
        
        anim.duration = 1
        anim.delegate = self
        
        // add animation to current view - 不知道有什么用
        anim.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        self.twitterMask?.add(anim, forKey: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.view.layer.mask = nil
    }
}
