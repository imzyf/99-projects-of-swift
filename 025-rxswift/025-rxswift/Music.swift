//
//  Music.swift
//  025-rxswift
//
//  Created by  moma on 2018/3/5.
//  Copyright © 2018年 yifans. All rights reserved.
//
import RxSwift

//歌曲结构体
struct Music {
    let name: String //歌名
    let singer: String //演唱者
    
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

//实现 CustomStringConvertible 协议，方便输出调试
extension Music: CustomStringConvertible {
    var description: String {
        return "name：\(name) singer：\(singer)"
    }
}


//歌曲列表数据源
struct MusicListViewModel {
    
    /// 一个可观察序列对象（Observable Squence）
    /// 简单说就是“序列”可以对这些数值进行“订阅（Subscribe）”，有点类似于“通知（NotificationCenter）”
    let data = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
    ])
}
