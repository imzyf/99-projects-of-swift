import UIKit
import BezierPathLength

class ChangeAnimationView: UIView, CAAnimationDelegate {
    
    // 按钮 三条线
    var topLineLayer: CAShapeLayer!
    var middleLineLayer: CAShapeLayer!
    var bottomLineLayer: CAShapeLayer!
    
    var topLayer: CALayer!
    var middleLayer: CALayer!
    var bottomLayer: CALayer!
    
    let raduis: CGFloat = 50.0
    let lineWidth: CGFloat =  50.0
    let lineGapHeight: CGFloat = 10.0
    let lineHeight: CGFloat = 8.0
    
    let kStep1Duration: CGFloat = 1.5
    let kStep2Duration: CGFloat = 1.5
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
        
        animationStep3()
      
    }
    
    func initLayers() {
        // top
          topLayer = CALayer()
        self.layer.addSublayer(topLayer)
        topLayer.frame = CGRect(x: (self.bounds.size.width - lineWidth)/2, y: kTopY, width: lineWidth, height: lineWidth)
        
        topLineLayer = CAShapeLayer()
        initLine(topLineLayer, in: topLayer)
        
        // middle
          middleLayer = CALayer()
        self.layer.addSublayer(middleLayer)
        middleLayer.frame = topLayer.frame
        middleLayer.frame.origin.y = kCenterY
        
        middleLineLayer = CAShapeLayer()
        initLine(middleLineLayer, in: middleLayer)
        
        // buttom
          bottomLayer = CALayer()
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
        lineLayer.fillColor = nil
        lineLayer.lineWidth = lineHeight
        lineLayer.lineCap = kCALineCapRound
        lineLayer.path = initPath.cgPath
        layer.addSublayer(lineLayer)
    }
    
    // 代理
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animationID = anim.value(forKey: "animationID") {
            switch animationID as! String {
                case "step1":
                    animationStep2()
                    break
                case "step2":
                    animationStep3()
                    break
                case "step3":
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
        animationGroup.duration = CFTimeInterval(kStep2Duration)
        animationGroup.setValue("step2", forKey: "animationID" )
        animationGroup.delegate = self
        middleLineLayer.add(animationGroup, forKey: nil)
        
    }
    
    func animationStep3() {
        // 开始点
        let startPoint = CGPoint(x: lineWidth/2, y: 0)
        
        // 1 - 向上的旋转 - endPoint 是圆上 -30°
        let angle30: CGFloat = .pi * 30 / 180
        // 结束点
        var endPoint = CGPoint()
        endPoint.x = lineWidth/2.0 + cos(angle30) * raduis
        endPoint.y = 0 - sin(angle30) * raduis
    
        // 控制点
        let controlPointX: CGFloat = lineWidth/2.0 +  acos(angle30) * raduis
        let controlPointY: CGFloat = 0
        let controlPoint = CGPoint(x: controlPointX, y: controlPointY)
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        // 计算 ac 长度
        let curveLength = path.length
        
        // 2 - 弧度 CD
        let pathCD = UIBezierPath(arcCenter: CGPoint(x: lineWidth/2, y: 0), radius: raduis, startAngle: .pi * 2 - angle30 , endAngle: .pi + angle30 , clockwise: false)
        
        path.append(pathCD)
        
        // 3 - DD'
        let pathDD = UIBezierPath(arcCenter: CGPoint(x: lineWidth/2, y: 0), radius: raduis, startAngle: .pi*3/2 - (.pi/2-angle30) , endAngle: -.pi/2 - (.pi/2-angle30) , clockwise: false)
        
        path.append(pathDD)
        
        middleLineLayer.path = path.cgPath
        
        //
        let calculateTotalLength = path.length
        //
        let originPercent: CGFloat = curveLength/calculateTotalLength
  
        let endPercent: CGFloat = (curveLength + raduis * 2/3 * .pi)/calculateTotalLength
   
        let startAnimation = CAKeyframeAnimation(keyPath: "strokeStart")
        startAnimation.values = [0.0, endPercent]
        
        let endAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        endAnimation.values = [originPercent, 1]

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [startAnimation, endAnimation]
        animationGroup.duration = CFTimeInterval(kStep2Duration)
//        animationGroup.setValue("step3", forKey: "animationID" )
        animationGroup.delegate = self
        middleLineLayer.add(animationGroup, forKey: nil)
    }
    
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
