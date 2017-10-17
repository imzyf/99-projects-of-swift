import UIKit

class ChangeAnimationView: UIView {
    
    // 按钮 三条线
    var topLineLayer: CAShapeLayer!
    var middleLineLayer: CAShapeLayer!
    var bottomLineLayer: CAShapeLayer!
    
    let raduis: CGFloat = 50.0
    let lineWidth: CGFloat =  50.0
    let lineGapHeight: CGFloat = 10.0
    let lineHeight: CGFloat = 8.0
    
    let kStep1Duration: CGFloat = 0.5
    let kStep2Duration: CGFloat = 0.5
    let kStep3Duration: CGFloat = 5.0
    let kStep4Duration: CGFloat = 5.0
    
    let kTopY: CGFloat!
    let kCenterY: CGFloat!
    let kBottomY: CGFloat!
    
    override init(frame: CGRect) {
        kTopY = raduis - lineGapHeight
        kCenterY = kTopY + lineGapHeight + lineHeight
        kBottomY = kCenterY + lineGapHeight + lineHeight
        
        super.init(frame: frame)
        self.backgroundColor = .orange
        
        initLayers()
    }
    
    func initLayers() {
        // top
        let topLayer = CALayer()
        self.layer.addSublayer(topLayer)
        topLayer.frame = CGRect(x: (self.bounds.size.width - lineWidth)/2, y: kTopY, width: lineWidth, height: lineWidth)
        
        topLineLayer = CAShapeLayer()
        initLine(topLineLayer, in: topLayer)
        
        // middle
        let middleLayer = CALayer()
        self.layer.addSublayer(middleLayer)
        middleLayer.frame = topLayer.frame
        middleLayer.frame.origin.y = kCenterY
        
        middleLineLayer = CAShapeLayer()
        initLine(middleLineLayer, in: middleLayer)
        
        // buttom
        let bottomLayer = CALayer()
        self.layer.addSublayer(bottomLayer)
        bottomLayer.frame = topLayer.frame
        bottomLayer.frame.origin.y = kBottomY
        
        bottomLineLayer = CAShapeLayer()
        initLine(bottomLineLayer, in: bottomLayer)
    }
    
    // 初始化 每一条线
    func initLine(_ lineLayer: CAShapeLayer, in layer: CALayer) {
        let initPath = UIBezierPath()
        initPath.move(to: CGPoint(x: 0, y: 0))
        initPath.addLine(to: CGPoint(x: lineWidth, y: 0))
        
        lineLayer.strokeColor = UIColor.white.cgColor
        lineLayer.lineWidth = lineHeight
        lineLayer.lineCap = kCALineCapRound
        lineLayer.path = initPath.cgPath
        layer.addSublayer(lineLayer)
    }
    
    func animationStep1() {
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
