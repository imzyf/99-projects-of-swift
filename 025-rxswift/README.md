# RxSwift

RxSwift RxCocoa 实现的 tableView 数据绑定和选中时间。

## Notice

将之前那些常用的事件传递方法（比如：delegate、notification、target-action 等等），全部替换成 Rx 的“信号链”方式。

`RxSwift`：它只是基于 Swift 语言的 Rx 标准实现接口库，所以 RxSwift 里不包含任何 Cocoa 或者 UI 方面的类。

`RxCocoa`：是基于 RxSwift 针对于 iOS 开发的一个库，它通过 Extension 的方法给原生的比如 UI 控件添加了 Rx 的特性，使得我们更容易订阅和响应这些控件的事件。

## Reference

- [hangge - RxSwift的使用详解](http://www.hangge.com/blog/cache/detail_1917.html)
