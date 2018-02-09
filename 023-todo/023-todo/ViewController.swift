//
//  ViewController.swift
//  023-todo
//
//  Created by  moma on 2018/1/22.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

var todos = [TodoModel]()

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let cellName = "todoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todos.append(TodoModel(image: "", title: "1.", dateTime: Date()))
        todos.append(TodoModel(image: "", title: "1.", dateTime: Date()))
        todos.append(TodoModel(image: "", title: "1.", dateTime: Date()))
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
 
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            return
        }
    }
    
}


