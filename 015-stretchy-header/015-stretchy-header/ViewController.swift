//
//  ViewController.swift
//  015-stretchy-header
//
//  Created by  moma on 2017/10/31.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let datas = [
        "when i was young",
        "i'd listen to the radio",
        "waiting for my favorite songs",
        "when they played i'd sing along",
        "it make me smile"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = datas[indexPath.row]
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 偏移量
        let offsetY = scrollView.contentOffset.y
        let tableHeight = tableView.frame.height
        // 偏移比例
        let validateOffsetY =  -offsetY / tableHeight
        let scaleFactor = 1 + validateOffsetY
 
        // 0.6 - 1.3
        print(scaleFactor)
        headerImageView.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}