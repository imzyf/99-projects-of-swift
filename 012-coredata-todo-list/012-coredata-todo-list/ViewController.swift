//
//  ViewController.swift
//  012-coredata-todo-list
//
//  Created by  moma on 2017/10/30.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var todoTableView: UITableView!
    
    var todoItems = [TodoItem]()
    let entityName = "TodoItem"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.getAllTodoItems()
    }
    
    
    @IBAction func addTodoItem(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Todo Item", message: "", preferredStyle:.alert)
        
        // add action
        alertController.addAction(UIAlertAction(title: "Add", style: .default) {
            [unowned self] action in
            
            if let fields = alertController.textFields  {
                self.storeItem(title: fields[0].text!, subTitle: fields[1].text!)
                
                self.getAllTodoItems()
                self.todoTableView.reloadData()
            }
        })
        // cancel action
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Todo Item Title"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Todo Item SubTitle"
        }
        
        self.present(alertController, animated: true)
    }
    
    // MARK:- CoreData
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func storeItem(title:String, subTitle:String) {
        // 1
        let context = getContext()
        
        // 2 定义一个entity，这个entity一定要在xcdatamodeld中做好定义
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let item = NSManagedObject(entity: entity!, insertInto: context)
        
        // 3
        item.setValue(title, forKey: "title")
        item.setValue(subTitle, forKey: "subTitle")
        item.setValue(ViewController.nextChecklistItemID(), forKey: "id")
        
        do {
            try context.save()
            print("saved")
        }catch{
            print(error)
        }
    }
    
    func deleteItem(forRowAt indexPath: IndexPath) {
        // 1
        let context = getContext()
        context.delete(todoItems[indexPath.row] as NSManagedObject)
        
        do {
            try context.save()
            self.todoItems.remove(at: indexPath.row)
            self.todoTableView.deleteRows(at: [indexPath], with: .fade)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // 获取某一entity的所有数据
    func getAllTodoItems() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            todoItems = try getContext().fetch(fetchRequest) as! [TodoItem]
        } catch {
            print("Could not fetch. \(error)")
        }
    }
    
    class func nextChecklistItemID() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "ChecklistItemID")
        userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        return itemID
    }
 
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let data = todoItems[indexPath.row]
        cell.textLabel?.text = "\(data.id) - \(data.title!)"
        cell.detailTextLabel?.text = data.subTitle
        
        return cell
    } 
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            self.deleteItem(forRowAt: indexPath)
        default:
            return
        }
    }
}
