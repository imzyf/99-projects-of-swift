//
//  OProgressView.swift
//  028-circle-progress
//
//  Created by  moma on 2018/3/26.
//  Copyright © 2018年 yifans. All rights reserved.
//

import UIKit

@IBDesignable class OProgressView: UIView {
 
    //进度条宽度
    var lineWidth: CGFloat = 8
    //进度槽颜色
    var trackColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
    //进度条颜色
    var progressColoar = UIColor.orange
    //每一段持续时间
    var duration = 0.1
  
    //进度槽
    let trackLayer = CAShapeLayer()
    //进度条
    let progressLayer = CAShapeLayer()
    //进度条路径（整个圆圈）
    let path = UIBezierPath()
    
    //当前进度
    @IBInspectable var progress: CGFloat = 0 {
        didSet {
            if progress > 100 {
                progress = 100
            }else if progress < 0 {
                progress = 0
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        //获取整个进度条圆圈路径
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.size.width/2 - lineWidth, startAngle: angleToRadian(-90), endAngle: angleToRadian(270), clockwise: true)
        
        //绘制进度槽
        trackLayer.frame = bounds
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.path = path.cgPath
        layer.addSublayer(trackLayer)
        
        //绘制进度条
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColoar.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.path = path.cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress/100.0
        layer.addSublayer(progressLayer)
    }
    
    //设置进度（可以设置是否播放动画）
    func setProgress(_ pro: CGFloat,animated anim: Bool) {
        setProgress(pro, animated: anim, withDuration: duration)
    }
    
    //设置进度（可以设置是否播放动画，以及动画时间）
    func setProgress(_ pro: CGFloat, animated anim: Bool, withDuration duration: Double) {
        progress = pro
        //进度条动画
        CATransaction.begin()
        CATransaction.setDisableActions(!anim)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut))
        CATransaction.setAnimationDuration(duration)
        progressLayer.strokeEnd = progress/100.0
        CATransaction.commit()
    }
    
    //将角度转为弧度
    fileprivate func angleToRadian(_ angle: Double)->CGFloat {
        return CGFloat(angle/Double(180.0) * .pi)
    }
}
