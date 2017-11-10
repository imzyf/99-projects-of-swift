# Self-sizing Table View Cells

## Demo

<img src="./017-demo.gif" alt="Self-sizing Table View Cells" width="300" />

## Introduction
自身内容决定的大小 TableViewCells。

1. 合理的约束。
2. 关键代码：

```Swift
tableView.rowHeight = UITableViewAutomaticDimension
tableView.estimatedRowHeight = 140
```

3. Swift 4 的 `Codable `运用。
4. `prefersLargeTitles` 运用。

## Notice
1. 取消掉 TextView 的 `Scrolling Enabled`，否则布局约束出错。
2. `Dynamic Type` 预置字体样式。
3. NotificationCenter 监听辅助中的字号变化。

## Reference
- [Self-sizing Table View Cells](https://www.raywenderlich.com/129059/self-sizing-table-view-cells)
- [soapyigu/Swift30Projects](https://github.com/soapyigu/Swift30Projects)
