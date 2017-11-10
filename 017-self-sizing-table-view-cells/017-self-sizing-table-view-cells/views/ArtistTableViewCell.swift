//
//  ArtistTableViewCell.swift
//  017-self-sizing-table-view-cells
//
//  Created by  moma on 2017/11/10.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nameLabel.textColor = UIColor.white
        self.nameLabel.backgroundColor = UIColor(red: 1, green: 152 / 255, blue: 0, alpha: 1)
        self.nameLabel.layer.cornerRadius = 3
        self.nameLabel.clipsToBounds = true
        self.bioLabel.textColor = UIColor(white: 114/255, alpha: 1)
        
        self.nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        self.bioLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }
}
