//
//  TodoModel.swift
//  023-todo
//
//  Created by  moma on 2018/1/22.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
    var id: String
    var image: String
    var title: String
    var date: Date
    
    init(id: String, image: String, title: String, date: Date) {
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}
