//
//  CustomPushTransition.swift
//  027-custom-transition
//
//  Created by  moma on 2018/3/13.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

class CustomPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    // 转场时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from) as! ViewController
        let toVC = transitionContext.viewController(forKey: .to) as! DetailViewController
        let containerView = transitionContext.containerView
        
        if let fromImageView = fromVC.selectedCell.viewWithTag(1001) as? UIImageView {
            let snapshotView = fromImageView.snapshotView(afterScreenUpdates: false)
            snapshotView?.frame = containerView.convert(fromImageView.frame, from: fromVC.selectedCell)
            
            toVC.view.frame = transitionContext.finalFrame(for: toVC)
            toVC.view.alpha = 0
            toVC.imageView.isHidden = true
            
            containerView.addSubview(toVC.view)
            containerView.addSubview(snapshotView!)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions(), animations: {
                snapshotView?.frame = toVC.imageView.frame
                fromVC.view.alpha = 0
                toVC.view.alpha = 1
            }) { (finish) in
                toVC.imageView.isHidden = false
                snapshotView?.removeFromSuperview()
                // 告诉系统你的动画过程已经结束，这是非常重要的方法，必须调用。
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
