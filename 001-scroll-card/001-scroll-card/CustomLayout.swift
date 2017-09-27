import UIKit

class CustomLayout: UICollectionViewFlowLayout {
    
    // 缩放因子
    private let ScaleFactor:CGFloat = 0.001

    override func prepare() {
        scrollDirection = .horizontal
        minimumLineSpacing = SIDE_WIDTH/2
        sectionInset = UIEdgeInsets(top: 0, left: SIDE_WIDTH, bottom: 0, right: SIDE_WIDTH)
        
        // 加速比例 默认值 0.998
        collectionView?.decelerationRate = 0.993
        
        super.prepare()
    }
    
    //（该方法默认返回false） 返回true
    // frame 发生改变就重新布局 内部会重新调用 prepare 和 layoutAttributesForElementsInRect
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 根据当前滚动进行对每个cell进行缩放
        // 首先获取 当前 rect 范围内的 attributes 对象
        let array = super.layoutAttributesForElements(in: rect)
        var arrayCopy = [UICollectionViewLayoutAttributes]()
        
        //计算缩放比  首先计算出整体中心点的X值 和每个cell的中心点X的值
        //用着两个x值的差值 ，计算出绝对值
        
        // colleciotnView 中心点的值
        let centerX = (collectionView?.contentOffset.x)! + (collectionView?.bounds.size.width)!/2
        
        // 循环遍历每个 attributes 对象，对每个对象进行缩放
        for attr in array! {
            let attrCopy = attr.copy() as! UICollectionViewLayoutAttributes
            
            //计算每个对象 cell 中心点的X值
            let cell_centerX = attrCopy.center.x
            
            //计算两个中心点的便宜（距离）
            //距离越大缩放比越小，距离小 缩放比越大，缩放比最大为1，即重合
            let distance = abs(cell_centerX-centerX)
            let scale:CGFloat = 1/(1+distance*ScaleFactor)
            attr.transform3D = CATransform3DMakeScale(1.0, scale, 1.0)
            
            arrayCopy.append(attrCopy)
        }
        
        return array
    }
    
    /// - Parameter proposedContentOffset: 手指滑动视图最终停止的便宜量，并不是手指离开时的偏移量
    /// - Returns: 返回最后停止后的点
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let visibleX = proposedContentOffset.x
        // 0 固定
        let visibleY = proposedContentOffset.y
        // 宽度固定
        let visibleW = collectionView?.bounds.size.width
        // 高度固定
        let visibleH = collectionView?.bounds.size.height

        // 获取可视区域
        let targetRect = CGRect(x: visibleX, y: visibleY, width: visibleW!, height: visibleH!)
        
        // 中心点的值
        let centerX = visibleX + visibleW!/2
        
        // 获取可视区域内的attributes对象
        let attrArr = super.layoutAttributesForElements(in: targetRect)!
       
        // 如果第0个属性距离最小
        var min_attr = attrArr[0]
        for attributes in attrArr {
            // 比较哪个元素的中心点距离 中心点近
            if (abs(attributes.center.x-centerX) < abs(min_attr.center.x-centerX)) {
                min_attr = attributes
            }
        }
        
        // 计算出距离中心点 最小的那个cell 和 整体中心点的偏移
        // 这两行还没有搞懂
        let offsetX = min_attr.center.x - centerX
        return CGPoint(x: visibleX+offsetX, y: visibleY)
    }
}
