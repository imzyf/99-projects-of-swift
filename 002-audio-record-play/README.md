# Audio Record And Play

## Demo

<img src="./002-demo.gif" alt="Audio Record And Play - demo" width="300" />

## Introduction
1. 导入 AVFoundation 框架。需要 AVAudioSession、AVAudioRecorder、AVAudioPlayer 等类。
2. 创建会话 session。sharedInstance 返回一个单例实例。
3. 请求用户授权进行录音。如果用户同意那么调用 setCategory 设置音频会话分类，本例中实现录音和播放等功能，所以会话类型选择 AVAudioSessionCategoryPlayAndRecord，否则提示用户进行设置。
4. 实例化一个音频录制者 AVAudioRecorder，指定录音保存的路径并且设置录音相关属性，注意因为录音机必须知道录音文件的格式、采样率、通道数、每个采样点的位数等信息，但是也并不是所有的信息都必须设置，通常只需要几个常用设置。AVAudioRecorder 为我们提供了 settings 属性字典用于设置相关信息。关于录音设置详见帮助文档中的 AV Foundation Audio Settings Constants。
5. 根据需求可以设置 AVAudioRecorder 的代理来监听录制情况。然后调用音频录制者的 prepareToRecord()，准备录制音频。
6. 最后根据按钮触发录制，停止，播放等基本功能，注意在播放部分我们将使用 AVAudioPlayer 获取本地存储文件进行播放操作，并且可以设置代理监听播放的情况。

## Problem

### 1
```
[access] This app has crashed because it attempted to access privacy-sensitive data
without a usage description.  
The app's Info.plist must contain an NSMicrophoneUsageDescription key with a string value
explaining to the user how the app uses this data.
```

add `NSMicrophoneUsageDescription` key in Info.plist

### 2
```
Warning: Attempt to present <UIAlertController: 0x100c0c1c0> on
<_02_audio_record_play.ViewController: 0x100c0a5d0>
whose view is not in the window hierarchy!
```

[whose view is not in the window hierarchy](https://stackoverflow.com/questions/11862883/whose-view-is-not-in-the-window-hierarchy)

The solution for me was to move this call to the `viewDidAppear:` method.

### 3
```
This application is modifying the autolayout engine from a background thread,
which can lead to engine corruption and weird crashes.
This will cause an exception in a future release.
```

[Getting a “This application is modifying the autolayout engine from a background thread” error?](https://stackoverflow.com/questions/28302019/getting-a-this-application-is-modifying-the-autolayout-engine-from-a-background)

```Swift
DispatchQueue.main.async {
   // Update UI
}
```

### 4
[Change AVAudioPlayer output to speaker in Swift](https://stackoverflow.com/questions/28630833/change-avaudioplayer-output-to-speaker-in-swift)
```
do {
    try self.audioSession.overrideOutputAudioPort(.speaker)
} catch let error {
    print("audioSession error: \(error.localizedDescription)")
}
```

### Reference

- [使用AVAudioRecorder录制声音(Swift)](http://blog.csdn.net/longshihua/article/details/52312284)
