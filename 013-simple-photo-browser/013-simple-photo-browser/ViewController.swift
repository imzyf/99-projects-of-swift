//
//  ViewController.swift
//  013-simple-photo-browser
//
//  Created by  moma on 2017/10/30.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var imageView:UIImageView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView(frame: self.view.frame)
        self.view.addSubview(scrollView)
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        scrollView.backgroundColor = .black
        scrollView.delegate = self
        
        imageView = UIImageView(image: #imageLiteral(resourceName: "samplePhoto"))
        scrollView.addSubview(imageView)
        imageView.frame = self.view.frame
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

