//
//  Utils.swift
//  023-todo
//
//  Created by  moma on 2018/3/12.
//  Copyright © 2018年 yifans. All rights reserved.
//

import Foundation

func dateFromString(_ date: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: date)
}

func stringFromDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}
