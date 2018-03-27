//
//  DetailViewController.swift
//  030-spotlight-search
//
//  Created by  moma on 2018/3/27.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var model: [String: Any]? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let model = model {
            imageView.image = model["cover"] as? UIImage
            titleLabel.text = model["name"] as? String
            descriptionLabel.text = model["description"] as? String
        }
    }
}
