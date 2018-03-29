//
//  CustomView.swift
//  026-safe-area
//
//  Created by  moma on 2018/3/29.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

class LabelCustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        label.numberOfLines = 0
        label.text = "iOS 7 之后苹果给 UIViewController 引入了 topLayoutGuide 和 bottomLayoutGuide 两个属性来描述不希望被透明的状态栏或者导航栏遮挡的最高位置(status bar, navigation bar, toolbar, tab bar 等)。这个属性的值是一个 length 属性( topLayoutGuide.length)。 这个值可能由当前的 ViewController 或者 NavigationController 或者 TabbarController 决定。一个独立的ViewController，不包含于任何其他的ViewController。如果状态栏可见，topLayoutGuide表示状态栏的底部，否则表示这个ViewController的上边缘。包含于其他ViewController的ViewController不对这个属性起决定作用，而是由容器ViewController决定这个属性的含义：如果导航栏（Navigation Bar）可见，topLayoutGuide表示导航栏的底部。如果状态栏可见，topLayoutGuide表示状态栏的底部。如果都不可见，表示ViewController的上边缘。这部分还比较好理解，总之是屏幕上方任何遮挡内容的栏的最底部。"
        addSubview(label)
    }
    
    var label = UILabel()
    
    override func layoutSubviews() {
        if #available(iOS 11.0, *) {
            label.frame = safeAreaLayoutGuide.layoutFrame
        } else {
            // Fallback on earlier versions
        }
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
