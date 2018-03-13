//
//  DetailViewController.swift
//  027-custom-transition
//
//  Created by  moma on 2018/3/13.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    fileprivate var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        
        //手势监听器
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanGestrueAction(_:)))
        edgePanGesture.edges = UIRectEdge.left
        view.addGestureRecognizer(edgePanGesture)
    }
    
    @objc func edgePanGestrueAction(_ edgePan:UIScreenEdgePanGestureRecognizer) {
        
        let progress = edgePan.translation(in: self.view).x / self.view.bounds.width
        
        print(progress)
        
        if edgePan.state == UIGestureRecognizerState.began {
            percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            navigationController?.popViewController(animated: true)
        } else if edgePan.state == UIGestureRecognizerState.changed {
            percentDrivenTransition?.update(progress)
        } else if edgePan.state == UIGestureRecognizerState.cancelled || edgePan.state == UIGestureRecognizerState.ended {
            if progress > 0.5 {
                percentDrivenTransition?.finish()
            } else {
                percentDrivenTransition?.cancel()
            }
            percentDrivenTransition = nil
        }
    }
}

extension DetailViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            return CustomPopTransition()
        default:
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController is CustomPopTransition {
            return percentDrivenTransition
        } else {
            return nil
        }
    }
}


