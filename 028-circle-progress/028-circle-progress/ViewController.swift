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
    var step: CGFloat = 0.1

    override func viewDidLoad() {
        super.viewDidLoad()
 
        progressView.frame.size = CGSize(width: 150, height: 150)
        progressView.center = view.center
        view.addSubview(progressView)

        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(step), repeats: true) { (_) in
            self.updateProgress()
        }
    }
    
    func updateProgress() {
        progress += step
        progressView.setProgress(progress * (1000.0/100.0), animated: true)
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
