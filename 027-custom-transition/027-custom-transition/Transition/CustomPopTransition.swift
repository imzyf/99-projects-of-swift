//
//  CustomPopTransition.swift
//  027-custom-transition
//
//  Created by  moma on 2018/3/13.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

class CustomPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! DetailViewController
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! ViewController
        let container = transitionContext.containerView
        
        if let toImageView = toVC.selectedCell.viewWithTag(1001) as? UIImageView {
            let snapshotView = fromVC.imageView.snapshotView(afterScreenUpdates: false)
            snapshotView?.frame = container.convert(fromVC.imageView.frame, from: fromVC.view)
            fromVC.imageView.isHidden = true
            
            toVC.view.frame = transitionContext.finalFrame(for: toVC)
            toVC.view.alpha = 0
            container.insertSubview(toVC.view, belowSubview: fromVC.view)
            container.addSubview(snapshotView!)
            
            toImageView.isHidden = true
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions(), animations: {
                snapshotView?.frame = container.convert(toImageView.frame, from: toVC.selectedCell)
                fromVC.view.alpha = 0
                toVC.view.alpha = 1
            }) { (finish) in
                toImageView.isHidden = false
                fromVC.imageView.isHidden = false
                snapshotView?.removeFromSuperview()
                // 告诉系统你的动画过程已经结束，这是非常重要的方法，必须调用。
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
