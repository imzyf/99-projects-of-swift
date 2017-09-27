# Scroll Card

## Demo

<img src="./001-demo.gif" alt="Scroll Card - demo" width="300" />

## Problem
### 1
```
This is likely occurring because the flow layout subclass _01_scroll_card.CustomLayout is modifying attributes returned by UICollectionViewFlowLayout without copying them
```

[XCode 7: Copy Layoutattributes](https://stackoverflow.com/questions/32720358/xcode-7-copy-layoutattributes)

```Swift
override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let attributes = super.layoutAttributesForElementsInRect(rect)
    var attributesCopy = [UICollectionViewLayoutAttributes]()
    for itemAttributes in attributes! {
        let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
        // add the changes to the itemAttributesCopy                       
        attributesCopy.append(itemAttributesCopy)
    }

    return attributesCopy
}
```

## Reference

- [swift实现卡片横向滑动效果](http://www.jianshu.com/p/0f31f0d64870)
