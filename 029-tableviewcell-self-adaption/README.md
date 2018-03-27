# Self-sizing UITextView in cell

UITableViewCell 自适应 UITextView 高度。

## GIF

<img src="https://user-images.githubusercontent.com/9289792/37953137-931860e0-31d4-11e8-8809-c871b09f9519.gif" alt="Self-sizing UITextView in cell" width="200" />

## 知识点
- UITextView 的 `scrollEnable` 要设置 false
- 更新 UITextView 的高度使用 `beginUpdates` 和 `endUpdates`
- 解决当页面超过一屏时的跳动问题

## Reference

> - [Self-sizing UITextView in a UITableView using Auto Layout (like Reminders.app)](http://candycode.io/self-sizing-uitextview-in-a-uitableview-using-auto-layout-like-reminders-app/)
> - [iOS UITextView 输入内容实时更新 cell 的高度](http://vit0.com/blog/2014/12/25/ios-textview-in-cell/)
