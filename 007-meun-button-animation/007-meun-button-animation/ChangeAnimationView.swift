import UIKit
import BezierPathLength

class ChangeAnimationView: UIView, CAAnimationDelegate {
    
    // 按钮 三条线
    var topLineLayer: CAShapeLayer!
    var middleLineLayer: CAShapeLayer!
    var bottomLineLayer: CAShapeLayer!
    
    let raduis: CGFloat = 50.0
    let lineWidth: CGFloat = 50.0
    let lineGapHeight: CGFloat = 10.0
    let lineHeight: CGFloat = 8.0
    
    let kStep1Duration: CGFloat = 0.3
    let kStep2Duration: CGFloat = 0.3
    let kStep3Duration: CGFloat = 1.0
    let kStep4Duration: CGFloat = 1.0
    
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
        let  middleLayer = CALayer()
        self.layer.addSublayer(middleLayer)
        middleLayer.frame = topLayer.frame
        middleLayer.frame.origin.y = kCenterY
        
        middleLineLayer = CAShapeLayer()
        initLine(middleLineLayer, in: middleLayer)
        
        // buttom
        let  bottomLayer = CALayer()
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
                // 清除原来的路径 - don't know why
                middleLineLayer.path = nil
                topLineLayer.path = nil
                bottomLineLayer.path = nil
                initLayers()
                animationStep1()
                break
            default: break
            }
        }
    }
    
    func animationStep1() {
        let strokAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokAnimation.fromValue = 1.0
        strokAnimation.toValue = 0.7
        
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
        strokAnimation.fromValue = 0.7
        strokAnimation.toValue = 0.5
        
        let pathAnimation = CABasicAnimation(keyPath: "position.x")
        pathAnimation.fromValue = -10.0
        pathAnimation.toValue = 0.5*lineWidth
        
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
        let angle: CGFloat = .pi * 30 / 180
        // 结束点
        var endPoint = CGPoint()
        endPoint.x = lineWidth/2.0 + cos(angle) * raduis
        endPoint.y = 0 - sin(angle) * raduis
        
        // 控制点
        let controlPointX: CGFloat = lineWidth/2.0 +  acos(angle) * raduis
        let controlPointY: CGFloat = 0
        let controlPoint = CGPoint(x: controlPointX, y: controlPointY)
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        // 计算 ac 长度
        let curveLength = path.length
        
        // 2 - 弧度 CD
        let pathCD = UIBezierPath(arcCenter: CGPoint(x: lineWidth/2, y: 0), radius: raduis, startAngle: .pi * 2 - angle , endAngle: .pi + angle , clockwise: false)
        
        path.append(pathCD)
        
        // 3 - DD'
        let pathDD = UIBezierPath(arcCenter: CGPoint(x: lineWidth/2, y: 0), radius: raduis, startAngle: .pi*3/2 - (.pi/2-angle) , endAngle: -.pi/2 - (.pi/2-angle) , clockwise: false)
        
        path.append(pathDD)
        
        middleLineLayer.path = path.cgPath
        
        // path 总长度
        let pathTotalLength = path.length
        
        // 初始笔记：拐角弧线的三分之一 （视觉测试）
        let originPercent: CGFloat = curveLength/pathTotalLength/3
        // 尾迹：拐角弧线 + 120° 弧线
        let endPercent: CGFloat = (curveLength + raduis * (.pi - 2*angle))/pathTotalLength
        
        let endAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        endAnimation.values = [originPercent, 1]
        
        let startAnimation = CAKeyframeAnimation(keyPath: "strokeStart")
        startAnimation.values = [0.0, endPercent]
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [startAnimation, endAnimation]
        animationGroup.duration = CFTimeInterval(kStep3Duration)
        animationGroup.setValue("step3", forKey: "animationID" )
        animationGroup.delegate = self
        
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = false
        
        middleLineLayer.add(animationGroup, forKey: nil)
        
        animationStep3_1()
    }
    
    func animationStep3_1() {
        
        // 平移量 - don't know why
        let toValue: CGFloat = lineWidth * (1 - cos(.pi/4)) / 2.0;
        
        let xRotationAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        xRotationAnimation.values = [0,toValue]
        let angle10: CGFloat = .pi * 10 / 180
        
        let zRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        zRotationAnimation.values = [0, angle10, -(angle10+CGFloat.pi/4), -CGFloat.pi/4]
        
        
        let zTopRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        zTopRotationAnimation.values = [0, -angle10, (angle10+CGFloat.pi/4), CGFloat.pi/4]
        
        var animationGroup = CAAnimationGroup()
        animationGroup.animations = [xRotationAnimation ,zTopRotationAnimation]
        animationGroup.duration = CFTimeInterval(kStep3Duration)
        animationGroup.delegate = self
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = false
        topLineLayer.add(animationGroup, forKey: nil)
        
        animationGroup = CAAnimationGroup()
        animationGroup.animations = [xRotationAnimation ,zRotationAnimation]
        animationGroup.duration = CFTimeInterval(kStep3Duration)
        animationGroup.delegate = self
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = false
        bottomLineLayer.add(animationGroup, forKey: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
