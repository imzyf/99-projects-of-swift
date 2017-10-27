//
//  ViewController.swift
//  010-pull-to-refresh
//
//  Created by  moma on 2017/10/27.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [Article]()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        tableView.addSubview(refreshControl)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseCellForPullToRefresh")
        
        let atricle = dataSource[indexPath.row]
        cell.textLabel?.text = atricle.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.detailTextLabel?.text = dateFormatter.string(from: atricle.createDate)
        
        return cell
    }
    
    @objc func refreshData() {
        
        let article = Article(title: "新闻标题 \(arc4random()%100)", createDate: Date())
        
        // 头部插入
        dataSource.insert(article, at: 0)
 
        // 延时1秒执行
        let time: TimeInterval = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        } 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

struct Article {
    var title:String
    var createDate:Date
}

