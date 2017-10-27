//
//  ViewController.swift
//  009-limited-input-text-field
//
//  Created by  moma on 2017/10/26.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var toolsView: UIView!
    
    let allowTextLength = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(note:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return range.location + text.count <= allowTextLength
    }
    
    func textViewDidChange(_ textView: UITextView) {
        countLabel.text = "\(allowTextLength - textView.text.count)"
    }
    
    @IBAction func doneAction() {
        tweetTextView.text.removeAll()
        countLabel.text = "\(allowTextLength)"
    }
    
    @objc func keyboardWillChangeFrame(note: Notification) {
        
        if let userInfo = note.userInfo {
            // 动画时间
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
            // TODO 类型转换不太清楚
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let bottomMargin = UIScreen.main.bounds.height - endFrame.origin.y
            
            UIView.animate(withDuration: duration) {
                if bottomMargin > 0 {
                    self.toolsView.frame.origin.y -= bottomMargin
                } else {
                    self.toolsView.frame.origin.y = self.view.frame.height - 50
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

// 点击其他位置，隐藏键盘
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

