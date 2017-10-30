# Video Player

## Demo

<img src="./011-demo.gif" alt="Video Player" width="300" />

## Introduction
视频播放。

1. `AVPlayerViewController`。
2. 允许 `https`。`NSAppTransportSecurity` `NSAllowsArbitraryLoads` in plist。

```
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

## Reference
- [allenwong/30DaysofSwift - 3](https://github.com/allenwong/30DaysofSwift)
- [抓住iOS的未来 - 30天学习编写30个Swift小程序 - 6](http://www.jianshu.com/p/c6ae28964ad5)
- [Transport security has blocked a cleartext HTTP](https://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http)
