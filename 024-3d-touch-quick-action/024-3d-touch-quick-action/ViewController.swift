//
//  ViewController.swift
//  024-3d-touch-quick-action
//
//  Created by  moma on 2018/2/9.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var actionImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(shortCutActionClicked(sender:)), name: Notification.Name(rawValue: "ShortcutAction"), object: nil)
        registerForPreviewing(with: self, sourceView: view)
    }
    
    @objc func shortCutActionClicked(sender: Notification) {
        if let shortcutItem = sender.userInfo?["shortcutItem"] as? UIApplicationShortcutItem, shortcutItem.type == "LoveItem" {
            actionLabel.text = "Yes, I do ❤️ you!"
        }
    }
}

extension ViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        return SFSafariViewController(url: URL(string: "https://zyf.im")!)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
}

extension SFSafariViewController {
    
    // 重新下部按钮
    open override var previewActionItems: [UIPreviewActionItem] {
        let deleteAction = UIPreviewAction(title: "删除", style: .destructive) { (previewAction, vc) in
            print("Delete")
        }
        let doneAction = UIPreviewAction(title: "完成", style: .default) { (previewAction, vc) in
            print("Done")
        }
        return [deleteAction, doneAction]
    }
}

