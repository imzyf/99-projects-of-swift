//
//  ViewController.swift
//  025-rxswift
//
//  Created by  moma on 2018/3/5.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// from http://www.hangge.com/blog/cache/detail_1918.html
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let cellName = "cellName"
    
    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel()
    
    //负责对象销毁
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 这里我们不再需要实现数据源和委托协议了。而是写一些响应式代码，让它们将数据和 UITableView 建立绑定关系。
        
        /*
         代码的简单说明：
         DisposeBag：作用是 Rx 在视图控制器或者其持有者将要销毁的时候，自动释法掉绑定在它上面的资源。它是通过类似“订阅处置机制”方式实现（类似于 NotificationCenter 的 removeObserver）。
         
         rx.items(cellIdentifier:）:这是 Rx 基于 cellForRowAt 数据源方法的一个封装。传统方式中我们还要有个 numberOfRowsInSection 方法，使用 Rx 后就不再需要了（Rx 已经帮我们完成了相关工作）。
        
         rx.modelSelected： 这是 Rx 基于 UITableView 委托回调方法 didSelectRowAt 的一个封装。
         */
        
        // 将数据源数据绑定到tableView上
        musicListViewModel.data.bind(to: tableView.rx.items(cellIdentifier: cellName)) { _, music, cell in
            cell.textLabel?.text = music.name
            cell.detailTextLabel?.text = music.singer
        }.disposed(by: disposeBag)
        
        // tableView点击响应
        tableView.rx.modelSelected(Music.self).subscribe(onNext: { music in
            print("你选中的歌曲信息【\(music)】")
        }).disposed(by: disposeBag)
    }
}

