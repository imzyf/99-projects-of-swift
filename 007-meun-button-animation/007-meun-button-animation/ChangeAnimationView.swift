import UIKit

class ChangeAnimationView: UIView, CAAnimationDelegate {
    
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
        
        animationStep1()
      
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
    
    // 执行 delegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animationID = anim.value(forKey: "animationID") {
            switch animationID as! String {
                case "step1":
                    animationStep2()
                    break
                case "step2":
                    animationStep1()
                    break
                default: break
            }
            
 
        }
    }
    
    func animationStep1() {
        let strokAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokAnimation.fromValue = 1.0
        strokAnimation.toValue = 0.4
        
        let pathAnimation = CABasicAnimation(keyPath: "position.x")
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = -10.0
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokAnimation, pathAnimation]
        animationGroup.duration = CFTimeInterval(kStep1Duration)
        animationGroup.setValue("step1", forKey: "animationID" )
        animationGroup.delegate = self
        middleLineLayer.add(animationGroup, forKey: nil)
        
    }
 
    func animationStep2() {
        let strokAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokAnimation.fromValue = 0.4
        strokAnimation.toValue = 0.8
        
        let pathAnimation = CABasicAnimation(keyPath: "position.x")
        pathAnimation.fromValue = -10.0
        pathAnimation.toValue = 0.2*lineWidth
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokAnimation, pathAnimation]
        animationGroup.duration = CFTimeInterval(kStep1Duration)
        animationGroup.setValue("step2", forKey: "animationID" )
        animationGroup.delegate = self
        middleLineLayer.add(animationGroup, forKey: nil)
        
    }
    
    func animationStep3() {
        let path = UIBezierPath()
       
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
