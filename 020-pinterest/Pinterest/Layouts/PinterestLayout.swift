//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by  moma on 2017/11/21.
//  Copyright © 2017年 Razeware LLC. All rights reserved.
//

import UIKit

class PinterestLayout: UICollectionViewLayout {
  
  weak var delegate: PinterestLayoutDelegate!
  
  fileprivate var numberOfColumns = 2
  fileprivate var cellPadding: CGFloat = 6
  
  fileprivate var cache = [UICollectionViewLayoutAttributes]()
  
  fileprivate var contentHeight: CGFloat = 0
  
  fileprivate var contentWidth: CGFloat {
    guard let collectionView = collectionView else {
      return 0
    }
    let insets = collectionView.contentInset
    return collectionView.bounds.width - (insets.left + insets.right)
  }
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  // 核心代码
  override func prepare() {
    guard cache.isEmpty, let collectionView = collectionView else {
      return
    }
    
    // 每一列的宽度
    let columnWidth = contentWidth / CGFloat(numberOfColumns)
    // 水平偏移量
    var xOffset = [CGFloat]()
    for column in 0 ..< numberOfColumns {
      xOffset.append(CGFloat(column) * columnWidth)
    }
    
    var column = 0
    // 每一列 y 的偏移量，初始化为 0
    var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
    // 遍历每个元素
    for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
      // 计算每个 frame
      let indexPath = IndexPath(item: item, section: 0)

      let photoHeight = delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
      let height = cellPadding * 2 + photoHeight
      let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = insetFrame
      cache.append(attributes)
 
      contentHeight = max(contentHeight, frame.maxY)
      yOffset[column] += height
      
      // 列指针变化
      column = column < (numberOfColumns - 1) ? (column + 1) : 0
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    
    // Loop through the cache and look for items in the rect
    for attributes in cache {
      if attributes.frame.intersects(rect) {
        visibleLayoutAttributes.append(attributes)
      }
    }
    return visibleLayoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[indexPath.item]
  }
}

protocol PinterestLayoutDelegate: class {
  func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
}
