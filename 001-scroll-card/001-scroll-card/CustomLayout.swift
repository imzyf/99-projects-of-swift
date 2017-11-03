import UIKit

class CustomLayout: UICollectionViewFlowLayout {
    
    // 缩放因子
    private let scaleFactor: CGFloat = 0.001

    override func prepare() {
        super.prepare()
    
        // 加速比例 默认值 0.998
        // collectionView?.decelerationRate = 0.993
    }
    
    //（该方法默认返回false） 返回true
    // frame 发生改变就重新布局 内部会重新调用 prepare 和 layoutAttributesForElementsInRect
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    // 设置在滚动中各个cell的变化公式
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let array = super.layoutAttributesForElements(in: rect)

        //                c
        //           b    |    d
        //           |----|----|
        //  a        |    |    |
        //  |--------|----|----|----------------------|
        //  |     |----| |----|||----|                |
        //  |     |----| |----|||----|                |
        //  |--------|----|----|----------------------|
        //           |    |    |
        //           |----|----|
        //                |
     
        
        // 首先计算出整体中心点的X值 和每个cell的中心点X的值
        // 用着两个x值的差值，计算出绝对值
        // c = bd/2 + ab
        let collectionViewCenterX = (self.collectionView?.frame.size.width)! * 0.5 + (self.collectionView?.contentOffset.x)!
        
        for attributes in array! {
            // 计算两个中心点的（距离）
            // 距离越大缩放比越小，距离小 缩放比越大，缩放比最大为1，即重合
            let distance = abs(attributes.center.x - collectionViewCenterX)
            let scale:CGFloat = 1/(1+distance*scaleFactor)
            // 水平 和 垂直都缩放
            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        return array
    }
    
    // Parameter proposedContentOffset: 手指滑动视图最终停止的便宜量，并不是手指离开时的偏移量
    // Returns: 返回最后停止后的点
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
     
        let offsetX = proposedContentOffset.x
        let offsetY = proposedContentOffset.y // 0
      
        let viewW = collectionView?.bounds.size.width
        let viewH = collectionView?.bounds.size.height

        // 获取可视区域
        let targetRect = CGRect(x: offsetX, y: offsetY, width: viewW!, height: viewH!)
        
        // 中心点的值
        let centerX = offsetX + viewW!/2
        
        // 获取可视区域内的 attributes 对象
        let attrArr = super.layoutAttributesForElements(in: targetRect)!
       
        // 寻找据中心点最近的 cell
        var centerAttr = attrArr[0]
        for attributes in attrArr {
            // 比较哪个元素的中心点距离 中心点近
            if (abs(attributes.center.x-centerX) < abs(centerAttr.center.x-centerX)) {
                centerAttr = attributes
            }
        }
        
        // 计算出距离中心点 最小的那个cell 和 整体中心点的偏移 - 进行调整
        let fixOffsetX  = centerAttr.center.x - centerX
        return CGPoint(x: fixOffsetX+offsetX, y: offsetY)
    }
}
