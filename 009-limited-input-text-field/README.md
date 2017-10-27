# Limited Input Text Field

## Demo

<img src="./009-demo.gif" alt="Limited Input Text Field" width="300" />

## Introduction
输入框字数限制。

1. `textView(shouldChangeTextIn)` 监听文字变化。
2. `NotificationCenter.default.addObserver()` `NSNotification.Name.UIKeyboardWillChangeFrame` 监听键盘显示隐藏。

## TODO
- 敲击虚拟键盘时，底部 View 位置下落 - 待解决。

## Reference
- [抓住iOS的未来 - 30天学习编写30个Swift小程序 - 4](http://www.jianshu.com/p/c6ae28964ad5)
- [触碰任意位置来关闭 iOS 键盘，用 Swift](http://www.jianshu.com/p/e5c8999754fe)
