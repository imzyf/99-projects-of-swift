//
//  ViewController.swift
//  030-spotlight-search
//
//  Created by  moma on 2018/3/27.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit
import CoreSpotlight

public let notificationName = Notification.Name(rawValue: "receivedIdFromSpotlightSearch")

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = [
        ["name":"Dangal","cover":#imageLiteral(resourceName: "Dangal"),"description":"This is a warm and humorous inspirational story. Maha Via Singh Pe (Amirkhan) was a India national wrestling champion, forced to give up wrestling because of life. He wants his son to help him achieve his dream - to win a world class gold medal. The results gave birth to four daughters thought this dream shattered Singer unexpectedly found her amazing talent on the body, see the champions hope he was determined not to let the talent waste daughter, like other girls can only cook over a lifetime, after consideration, agreed with his wife a year two daughters training according to the wrestler standard: replace the skirt, cut my hair, let them practice wrestling, and won a championship final to win the women the opportunity to become a model inspired thousands on thousands of.","ranking":8.6],
        ["name":"Guardians of the Galaxy","cover":#imageLiteral(resourceName: "Guardians of the Galaxy"),"description":"The Galactic guards cross the universe in this focus, continuing epic adventures in outer space. They must fight together, protect each other, and unravel the mystery of the star Peter Quill. The old enemy became allies, and the favorite characters in the comics would show up and help the guards.Along with the 'second series of songs' the background music, the Milky Way convoy to the more distant cosmic star domain, while efforts to maintain this new family while not easily won, trying to uncover the mystery of the truth Peter Quel descent. In this journey, the enemies of the past will become allies of today, and the classic comic characters who are loved by fans will come to help our hero.","ranking":7.9],
        ["name":"Absurd Accident","cover":#imageLiteral(resourceName: "Absurd Accident"),"description":"Northeast, Yang million and his wife Ma Lilian runs 'Cyclamen hotel'. Yang Baiwan was not for middle-aged patients, but Ma Lilian is a sexy, bold tiger Yang Baiwan, low self-esteem, worried all day. Finally one day, Yang million that Ma Lilian was a cuckold for himself, angrily found a doctor after work, two people planning a revenge on Ma Lilian's plan... That night, the killer rujierzhi, two robbers and a couple of temporary but came to the hotel and a strange combination of circumstances, both involved in the event. The few unrelated people originally interacted with each other, making the already confusing situation even more surprising. Everyone has experienced a fearful experience in order to achieve his goal, and then a series of absurd and funny things happen. At the same time, their fortunes changed...","ranking":7.0]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotification(sender:)), name: notificationName, object: nil)
        
        var searchItems: [CSSearchableItem] = []
        for (k, model) in dataSource.enumerated() {
            let attributSet = CSSearchableItemAttributeSet(itemContentType: "test")
            attributSet.title = model["name"] as? String
            attributSet.contentDescription = model["description"] as? String
            attributSet.thumbnailData = UIImageJPEGRepresentation((model["cover"] as? UIImage)!, 0.7)
            let ranking = model["ranking"] as? Double ?? 0
            attributSet.rating = (ranking / 2 ) as NSNumber
            let searchItem = CSSearchableItem(uniqueIdentifier: "\(k)", domainIdentifier: "im.zyf", attributeSet: attributSet)
            searchItems.append(searchItem)
        }
        CSSearchableIndex.default().indexSearchableItems(searchItems)
    }
    
    @objc func receivedNotification(sender: Notification) {
        let userInfo = sender.userInfo
        let row = Int(userInfo?["id"] as! String) ?? 0
        let indexPath = IndexPath(row: row, section: 0)
        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailViewController = segue.destination as! DetailViewController
            let indexPath = sender as! IndexPath
            let model = dataSource[indexPath.row]
            detailViewController.model = model
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellName", for: indexPath)
        let itemDic = dataSource[indexPath.row]
        cell.imageView?.image = itemDic["cover"] as? UIImage
        cell.textLabel?.text = itemDic["name"] as? String
        cell.detailTextLabel?.text = itemDic["description"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
}