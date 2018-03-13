//
//  ViewController.swift
//  023-todo
//
//  Created by  moma on 2018/1/22.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

var todos: [ToDoItem] = []
var filteredTodos: [ToDoItem] = []

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let cellName = "todoCell"
    let search = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 除去多余的分割线
        tableView.tableFooterView = UIView(frame: .zero)
        
        todos = [ToDoItem(id: "1", image: "child-selected", title: "Go to Disney", date: dateFromString("2014-10-20")!),
                 ToDoItem(id: "2", image: "shopping-cart-selected", title: "Cicso Shopping", date: dateFromString("2014-10-28")!),
                 ToDoItem(id: "3", image: "phone-selected", title: "Phone to Jobs", date: dateFromString("2014-10-30")!),
                 ToDoItem(id: "4", image: "travel-selected", title: "Plan to Europe", date: dateFromString("2014-10-31")!)]
        
        // 知识点 编辑按钮
        navigationItem.leftBarButtonItem = editButtonItem
        
        // 知识点 搜索栏
        search.searchResultsUpdater = self
        // 结果就在本视图 取消遮罩
        search.dimsBackgroundDuringPresentation = false
        // 点击搜索结果时，保证 navigation 的正常显示
        definesPresentationContext = true
        navigationItem.searchController = search
        // https://stackoverflow.com/questions/41747551/navigating-to-a-view-push-from-a-search-results-table-uisearchcontroller-and
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTodo" {
            let vc = segue.destination as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            if let indexPath = indexPath {
                vc.todo = todos[indexPath.row]
            }
        }
    }
    
    // Edit mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return search.isActive ? filteredTodos.count : todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = search.isActive ? filteredTodos[indexPath.row] : todos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        if let imageView = cell.viewWithTag(1001) as? UIImageView, let titleLabel = cell.viewWithTag(1002) as? UILabel, let dateLabel = cell.viewWithTag(1003) as? UILabel {
            imageView.image = UIImage(named: todo.image)
            titleLabel.text = todo.title
            dateLabel.text = stringFromDate(todo.date)
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    // Delete the cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            return
        }
    }
    
    // Move the cell
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return isEditing
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = todos.remove(at: sourceIndexPath.row)
        todos.insert(todo, at: (destinationIndexPath.row))
    }
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        filteredTodos = todos.filter { $0.title.lowercased().range(of: text.lowercased()) != nil }
        tableView.reloadData()
    }
}
