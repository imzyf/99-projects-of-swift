//
//  ViewController.swift
//  028-circle-progress
//
//  Created by  moma on 2018/3/26.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var progress: CGFloat = 0
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
 
        progressView.frame.size = CGSize(width: 150, height: 150)
        progressView.center = view.center
        view.addSubview(progressView)

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (_) in
            self.updateProgress()
        }
    }
    
    func updateProgress() {
        progress += CGFloat(100.0/600.0)
        progressView.setProgress(progress, animated: true)
        if progress > 95 {
            timer?.invalidate()
        }
    }

    lazy var progressView: OProgressView = {
        let view = OProgressView()
        view.backgroundColor = .white
        view.progressColoar = .red
        return view
    }()
}