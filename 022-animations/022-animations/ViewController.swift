//
//  ViewController.swift
//  022-animations
//
//  Created by  moma on 2017/11/24.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let items = ["2-Color", "Simple 2D Rotation", "Multicolor", "Multi Point Position", "BezierCurve Position", "Color and Frame Change", "View Fade In", "Pop"]
 
    let cellHeight: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableAnimate()
    }

    func tableAnimate() {
        tableView.reloadData()
        
        let cells = self.tableView.visibleCells
        let tableHeight = self.tableView.bounds.height
        
        // move all cells to the bottom of the screen
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        // move all cells from bottom to the right place
        for (index, cell) in cells.enumerated() {
            UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        
        // 颜色因子 - 橙色为基色
        let upperFactor: CGFloat = CGFloat(indexPath.row) / CGFloat(items.count )
        let lowerFactor: CGFloat = upperFactor - 0.2
        let upperColor: CGColor = UIColor(red: 1.0, green: 147/255, blue: upperFactor, alpha: 1).cgColor
        let lowerColor: CGColor = UIColor(red: 1.0, green: 147/255, blue: lowerFactor, alpha: 1).cgColor
        
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: cellHeight))
        // ['ɡredɪənt] 梯度
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [lowerColor, upperColor]
        gradientLayer.frame = bgView.bounds
        bgView.layer.addSublayer(gradientLayer)
        
        cell.addSubview(bgView)
        // 先后移动视图
        cell.sendSubview(toBack: bgView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Basic Animations"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
}

