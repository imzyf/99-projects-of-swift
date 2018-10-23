//
//  ViewController.swift
//  031-stopwatch
//
//  Created by  moma on 2018/3/28.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var lapRestButton: UIButton!
    @IBOutlet weak var lapsTableView: UITableView!
    
    // MARK: - Variables
    fileprivate let mainStopwatch: Stopwatch = Stopwatch()
    fileprivate let lapStopwatch: Stopwatch = Stopwatch()
    fileprivate var isPlay: Bool = false
    fileprivate var laps: [String] = []
    
    let stepTimeInterval: CGFloat = 0.035
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 闭包设置 button 样式
        let initCircleButton: (UIButton) -> Void = { button in
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
        }
        initCircleButton(playPauseButton)
        initCircleButton(lapRestButton)
        
        playPauseButton.setTitle("Stop", for: .selected)
        lapRestButton.isEnabled = false
    }
    
    @IBAction func playPauseTimer(_ sender: UIButton) {
        if sender.isSelected {
            // stop
            mainStopwatch.timer.invalidate()
            
        } else {
            // start
            lapRestButton.isEnabled = true
            mainStopwatch.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.stepTimeInterval), repeats: true) { (time) in
                self.updateTimer(self.mainStopwatch, label: self.timerLabel)
            }
            
            sender.isSelected = !sender.isSelected
                
                
                
//
//                Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
//
            
            
            
        }
    }
    
    func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.counter = stopwatch.counter + stepTimeInterval
        let minutes = Int(stopwatch.counter / 60)
        let minuteText = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        
        let seconds = stopwatch.counter.truncatingRemainder(dividingBy: 60)
        let secondeText = seconds < 10 ? String(format: "0%.2f", seconds) : String(format: "%.2f", seconds)
        
        label.text = minuteText + ":" + secondeText
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        
//        if let labelNum = cell.viewWithTag(11) as? UILabel {
//            labelNum.text = "Lap \(laps.count - (indexPath as NSIndexPath).row)"
//        }
//        if let labelTimer = cell.viewWithTag(12) as? UILabel {
//            labelTimer.text = laps[laps.count - (indexPath as NSIndexPath).row - 1]
//        }
        
        return cell
    }
}

