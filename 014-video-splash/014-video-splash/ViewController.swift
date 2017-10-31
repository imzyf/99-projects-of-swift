//
//  ViewController.swift
//  014-video-splash
//
//  Created by  moma on 2017/10/31.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class ViewController: VideoSplashViewController {
    
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
        
        // Sample UI
        let rect = view.frame
        let buttonHeight: CGFloat = 50
        
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        view.addSubview(logoImageView)
        logoImageView.frame = CGRect(x: 0, y: 50, width: rect.width*0.8, height: 80)
        logoImageView.center.x = self.view.center.x
        logoImageView.contentMode = .scaleAspectFit
        
        // login button
        let loginButton = UIButton(frame: CGRect(x: 0, y: (rect.height - buttonHeight), width: rect.width/2, height: buttonHeight))
        loginButton.setTitle("LOG IN", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor(red: 35/255.0, green: 36/255.0, blue: 38/255.0, alpha: 1)
        view.addSubview(loginButton)
        
        // signup button
        let signupButton = UIButton(frame: CGRect(x: rect.width/2, y: (rect.height - buttonHeight), width: rect.width/2, height: buttonHeight))
        signupButton.setTitle("SIGN UP", for: .normal)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.backgroundColor = UIColor(red: 42/255.0, green: 183/255.0, blue: 90/255.0, alpha: 1)
        view.addSubview(signupButton)
    }
    
    // override var prefersStatusBarHidden:Bool { return true }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

