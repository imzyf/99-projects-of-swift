//
//  ViewController.swift
//  005-change-font-name
//
//  Created by  moma on 2017/10/15.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    
    var familyNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        familyNames = UIFont.familyNames
        for familyName in familyNames {
            print("++++++ \(familyName)")
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
                print("----- \(fontName)")
            }
        }
    }

    @IBAction func changeFontFamily() {
        let name = familyNames[randomCustom(min: 0, max: familyNames.count)]
        nameLabel.text = name
        titleLabel.font = UIFont(name: name, size: 20)
    }
    
    // 左闭右开
    func randomCustom(min: Int, max: Int) -> Int {
        let y = arc4random() % UInt32(max) + UInt32(min)
        print(y)
        return Int(y)
    }

}

