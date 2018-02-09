//
//  TodoModel.swift
//  023-todo
//
//  Created by  moma on 2018/1/22.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

class TodoModel {
    
    var image: String!
    var title: String! 
    var dateTime: Date!
    
    init(image: String, title: String, dateTime: Date) {
        self.image = image
        self.title = title
        self.dateTime = dateTime
    }
}
