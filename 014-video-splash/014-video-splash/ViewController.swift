//
//  ViewController.swift
//  014-video-splash
//
//  Created by  moma on 2017/10/31.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class ViewController: VideoSplashViewController {
    
    let buttonHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "moments", ofType: "mp4") {
            let url = URL(fileURLWithPath: path)
            
            self.videoFrame = view.frame
            self.fillMode = .resizeAspectFill
            self.alwaysRepeat = true
            self.sound = true
            self.startTime = 12.0
            self.duration = 4.0
            self.alpha = 0.7
            self.backgroundColor = .black
            self.contentURL = url
            self.restartForeground = true
        }
        
        view.addSubview(logoImageView)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let safeArea = view.safeAreaInsets
        let rect = view.safeAreaLayoutGuide.layoutFrame
     
        logoImageView.frame = CGRect(x: 0, y: safeArea.top + 50, width: rect.width, height: 80)
        loginButton.frame = CGRect(x: 0, y: (safeArea.top + rect.height - buttonHeight), width: rect.width/2, height: buttonHeight)
        signupButton.frame = CGRect(x: loginButton.frame.maxX, y: loginButton.frame.minY, width: rect.width/2, height: buttonHeight)
    }
    
    lazy var logoImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "logo"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("LOG IN", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(red: 35/255.0, green: 36/255.0, blue: 38/255.0, alpha: 1)
        return btn
    }()
    
    lazy var signupButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("SIGN UP", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(red: 42/255.0, green: 183/255.0, blue: 90/255.0, alpha: 1)
        return btn
    }()
}

