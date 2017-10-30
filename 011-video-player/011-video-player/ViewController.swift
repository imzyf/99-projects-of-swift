//
//  ViewController.swift
//  011-video-player
//
//  Created by  moma on 2017/10/27.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet weak var videoTableView: UITableView!
    
    let datas = [
        video(image: "videoScreenshot01", title: "Introduce 3DS Mario", source: "Youtube - 06:32"),
        video(image: "videoScreenshot02", title: "Emoji Among Us", source: "Vimeo - 3:34"),
        video(image: "videoScreenshot03", title: "Seals Documentary", source: "Vine - 00:06"),
        video(image: "videoScreenshot04", title: "Adventure Time", source: "Youtube - 02:39"),
        video(image: "videoScreenshot05", title: "Facebook HQ", source: "Facebook - 10:20"),
        video(image: "videoScreenshot06", title: "Lijiang Lugu Lake", source: "Allen - 20:30")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.dataSource = self
        videoTableView.delegate = self
        
        videoTableView.separatorStyle = .none
        videoTableView.backgroundColor = .gray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = videoTableView.dequeueReusableCell(withIdentifier: "video_cell", for: indexPath) as! VideoTableViewCell
        let data = datas[indexPath.row]
        
        cell.videoImage.image = UIImage(named: data.image)
        cell.videoSourceLabel.text = data.title
        cell.videoInfoLabel.text = data.source
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

