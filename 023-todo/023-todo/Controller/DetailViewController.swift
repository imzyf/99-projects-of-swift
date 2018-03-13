//
//  DetailViewController.swift
//  023-todo
//
//  Created by  moma on 2018/3/12.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedBtn: UIButton?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    let btnDict = [1001: "child-selected",
                   1002: "phone-selected",
                   1003: "shopping-cart-selected",
                   1004: "travel-selected"]
    
    /// 修改对象
    var todo: ToDoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        
        // 加载修改
        if let todo = todo {
            // 设置 nav 标题
            title = "Edit Todo"
            let dict = btnDict.filter { $1 == todo.image }
            if let tag = dict.keys.first, let btn = view.viewWithTag(tag) as? UIButton {
                selectAction(btn)
            }
            titleTextField.text = todo.title
            datePicker.setDate(todo.date, animated: false)
        } else {
            title = "New Todo"
            if let btn = view.viewWithTag(1001) as? UIButton {
                selectAction(btn)
            }
        }
    }
    
    @IBAction func selectAction(_ sender: UIButton) {
        selectedBtn?.isSelected = false
        sender.isSelected = true
        selectedBtn = sender
    }
    
    @IBAction func doneAction(_ sender: UIButton) {
        let tag = selectedBtn!.tag
        let image = btnDict[tag] ?? ""
        guard selectedBtn != nil, titleTextField.text != nil, !titleTextField.text!.isEmpty, !image.isEmpty  else { return }
        
        if let todo = todo {
            todo.image = image
            todo.title = titleTextField.text!
            todo.date = datePicker.date
        } else {
            let uuid = UUID().uuidString
            todos.append(ToDoItem(id: uuid, image: image, title: titleTextField.text!, date: datePicker.date))
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
