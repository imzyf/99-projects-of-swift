//
//  Stopwatch.swift
//  031-stopwatch
//
//  Created by  moma on 2018/3/28.
//  Copyright © 2018年 yifans. All rights reserved.
//

import Foundation
import UIKit

class Stopwatch: NSObject {
    var counter: CGFloat
    var timer: Timer
    
    override init() {
        counter = 0.0
        timer = Timer()
    }
}
