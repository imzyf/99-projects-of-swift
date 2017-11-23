//
//  MessageSectionController.swift
//  Marslink
//
//  Created by  moma on 2017/11/23.
//  Copyright © 2017年 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class MessageSectionController: IGListSectionController {
    
    var message: Message!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
}

extension MessageSectionController: IGListSectionType {
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        return MessageCell.cellSize(width: context.containerSize.width, text: message.text)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(of: MessageCell.self, for: self, at: index) as! MessageCell
        cell.messageLabel.text = message.text
        cell.titleLabel.text = message.user.name.uppercased()
        return cell
    }
    
    func didUpdate(to object: Any) {
        message = object as? Message
    }
    
    func didSelectItem(at index: Int) {}
}
