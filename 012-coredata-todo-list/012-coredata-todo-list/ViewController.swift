//
//  ViewController.swift
//  012-coredata-todo-list
//
//  Created by  moma on 2017/10/30.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,
UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var todoTableView: UITableView!
 
    var datas = [TodoItem]()
    let entityName = "TodoItem"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        
        self.getAllTodoItems()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "item")
        
        let data = datas[indexPath.row]
        cell.textLabel?.text = "\(data.id) - \(data.title!)" 
        cell.detailTextLabel?.text = data.subTitle
        
        return cell
    }
    
    @IBAction func addTodoItem() {
        let alertController = UIAlertController(title: "New Todo Item", message: "", preferredStyle:.alert)
  
        // add action
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { (_) in
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
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK:- CoreData
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func storeItem(title:String, subTitle:String) {
        let context = getContext()
        // 定义一个entity，这个entity一定要在xcdatamodeld中做好定义
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        
        let item = NSManagedObject(entity: entity!, insertInto: context)
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
    
    // 获取某一entity的所有数据
    func getAllTodoItems() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            datas = searchResults as! [TodoItem]
        } catch  {
            print(error)
        }
    }
    
    class func nextChecklistItemID() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "ChecklistItemID")
        userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        return itemID
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

