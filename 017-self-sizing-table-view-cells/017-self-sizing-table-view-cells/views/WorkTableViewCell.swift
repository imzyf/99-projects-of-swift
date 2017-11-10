//
//  WorkTableViewCell.swift
//  017-self-sizing-table-view-cells
//
//  Created by  moma on 2017/11/10.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class WorkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var workImageView: UIImageView!
    @IBOutlet weak var workTitleLabel: UILabel!
    @IBOutlet weak var moreInfoTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.workTitleLabel.backgroundColor = UIColor(white: 204/255, alpha: 1)
        self.workTitleLabel.textAlignment = .center
        self.moreInfoTextView.textColor = UIColor(white: 114 / 255, alpha: 1)
        self.selectionStyle = .none
    }
}

