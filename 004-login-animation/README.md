# Login Animation

## Demo

<img src="./004-demo.gif" alt="Login Animation - demo" width="300" />

## Introduction

登录框的动效。

1. `.storyboard` 的自动布局。
2. `UIView.animate(withDuration, delay, usingSpringWithDamping, initialSpringVelocity, options, animations, completion)` 方法的使用。

- `usingSpringWithDamping` 值越小动画越夸张

![](./readme-img/usingSpringWithDamping.gif)

- `initialSpringVelocity` 值越大则起始速度越大

![](./readme-img/initialSpringVelocity.gif)

- `options` 的各个动画曲线

![](./readme-img/options.png)

- `Default` 与 `Spring` 的区别

![](./readme-img/Animation-Comparation.png)

### Reference

- [抓住iOS的未来 - 30天学习编写30个Swift小程序 - 16](http://www.jianshu.com/p/c6ae28964ad5)
