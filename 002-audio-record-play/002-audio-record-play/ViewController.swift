import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //audioRecorder 和 audioPlayer，一个用于录音，一个用于播放
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    //获取音频会话单例
    let audioSession = AVAudioSession.sharedInstance()
    var isAllowed: Bool = false
    
    let recordSettings = [
        // 声音采样率
        AVSampleRateKey : NSNumber(value: Float(44100.0)),
        // 编码格式 AAC
        AVFormatIDKey : NSNumber(value: Int32(kAudioFormatMPEG4AAC)),
        // 采集音轨
        AVNumberOfChannelsKey : NSNumber(value: 1),
        // 音频质量
        AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.medium.rawValue))
    ]
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "waiting"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 首先要判断是否允许访问麦克风
        audioSession.requestRecordPermission { (allowed) in
            self.isAllowed = allowed
            
            if self.isAllowed {
                do {
                    try self.audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                    do {
                        try self.audioSession.overrideOutputAudioPort(.speaker)
                    } catch let error {
                        print("audioSession error: \(error.localizedDescription)")
                    }
                    
                    // 初始化实例
                    try self.audioRecorder = AVAudioRecorder(url: self.directoryURL()!,settings: self.recordSettings)
                    // delegate
                    self.audioRecorder.delegate = self
                    // 准备录音
                    self.audioRecorder.prepareToRecord()
                    
                    DispatchQueue.main.async {
                        self.statusLabel.text = "Prepare To Record"
                    }
                } catch let error as NSError{
                    print(error)
                }
                
            } else {
                let alertView = UIAlertController(title: "无法访问您的麦克风", message: "请到设置 -> 隐私 -> 麦克风 ，打开访问权限", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
                alertView.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                
                self.present(alertView, animated: true, completion: nil)
                
                DispatchQueue.main.async {
                    self.statusLabel.text = "无法访问您的麦克风，无法使用"
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func directoryURL() -> URL? {
        // 定义并构建一个 url 来保存音频，音频文件名为 yyyyMMdd-HHmmss.caf
        // 根据时间来设置存储文件名
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd-HHmmss"
        // 以下2种格式都可以
        let recordingName = formatter.string(from: currentDateTime) + ".caf"
        // let recordingName = formatter.string(from: currentDateTime)+".m4a"
        
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as URL
        let soundURL = documentDirectory.appendingPathComponent(recordingName)
        
        print(soundURL)
        
        return soundURL
    }
    
    // 开始录音
    @IBAction func startRecord(_ sender: AnyObject) {
        // 如果正在播放，先停止播放
        if let audioPlayer = audioPlayer, audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        
        // 是否正在录音，如果没有，开始录音
        if !audioRecorder.isRecording {
            do {
                try audioSession.setActive(true)
                audioRecorder.record()
                
                statusLabel.text = "Recording"
            } catch let error {
                print(error)
            }
        }
    }
    
    // 停止录音
    @IBAction func stopRecord(_ sender: AnyObject) {
        if audioRecorder.isRecording {
            audioRecorder.stop()
            do {
                try audioSession.setActive(false)
                
                statusLabel.text = "Stop Record"
            } catch let error {
                print(error)
            }
        }
    }
    
    // 暂停录制
    @IBAction func pauseRecoder(_ sender: AnyObject) {
        if audioRecorder.isRecording{
            audioRecorder.pause()
            
            statusLabel.text = "Pause Record"
        }
    }
    
    // 恢复录制，恢复录音只需要再次调用 record，AVAudioSession 会帮助你记录上次录音位置并追加录音
    @IBAction func resumeRecoder(_ sender: AnyObject) {
        if (!audioRecorder.isRecording){
            self.startRecord(sender)
            
            statusLabel.text = "Recording"
        }
    }
    
    // 开始播放
    @IBAction func startPlaying(_ sender: AnyObject) {
        if !audioRecorder.isRecording {
            do {
               
                // 创建音频播放器 AVAudioPlayer，用于在录音完成之后播放录音
                try audioPlayer = AVAudioPlayer(contentsOf: audioRecorder.url)
                audioPlayer.delegate = self
                audioPlayer.play()
                
                statusLabel.text = "Playing"
                
            } catch let error {
                print(error)
            }
        }
    }
    
    // 暂停播放
    @IBAction func stopPlaying(_ sender: AnyObject) {
        if let audioPlayer = audioPlayer , audioPlayer.isPlaying{
            if (!audioRecorder.isRecording){
                audioPlayer.stop()
                
                statusLabel.text = "Stop Play"
            }
        }
    }
}

extension ViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            if #available(iOS 8.0, *) {
                let alert = UIAlertController(title: "Recorder",
                                              message: "Finished Recording",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: {action in
                    print("OK was tapped")
                    
                    self.statusLabel.text = "Finish Record"
                }))
                
                self.present(alert, animated:true, completion:nil)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

extension ViewController: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag{
            print("播放完成!")
            
            statusLabel.text = "Finish Play"
        }
    }
}

