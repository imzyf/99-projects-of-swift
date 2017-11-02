# Moya Simple

## Demo

<img src="./016-demo.gif" alt="Moya Simple" width="300" />

## Introduction
Moya 小例。

1. 首先我们定义一个 provider，即请求发起对象。往后我们如果要发起网络请求就使用这个 provider。
2. 接着声明一个 enum 来对请求进行明确分类，这里我们定义两个枚举值分别表示获取频道列表、获取歌曲信息。
3. 最后让这个 enum 实现 TargetType 协议，在这里面定义我们各个请求的 url、参数、header 等信息。

## Reference
- [Swift - 网络抽象层库Moya的使用详解1（安装配置、基本用法）](http://www.hangge.com/blog/cache/search.php?key=Moya)
