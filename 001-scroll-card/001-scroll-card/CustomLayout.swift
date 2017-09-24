//
//  CustomLayout.swift
//  001-scroll-card
//
//  Created by  moma on 2017/9/24.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class CustomLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        scrollDirection = UICollectionViewScrollDirection.horizontal
        minimumLineSpacing = 20.0
        sectionInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        super.prepare()
    }
}
