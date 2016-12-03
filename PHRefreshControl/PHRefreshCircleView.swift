//
//  CircleView.swift
//  圈
//
//  Created by 彭辉 on 2016/11/24.
//  Copyright © 2016年 彭辉. All rights reserved.
//

import UIKit
private let Duration = 1.0
class PHRefreshCircleView: UIView {

    
    private let layer1:CAShapeLayer = { () -> CAShapeLayer in
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.red.cgColor
        layer.lineWidth = 2
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()
    private let layer2:CAShapeLayer = { () -> CAShapeLayer in
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.yellow.cgColor
        layer.lineWidth = 2
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()
    private let layer3:CAShapeLayer = { () -> CAShapeLayer in
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.blue.cgColor
        layer.lineWidth = 2
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()
    private let layer4:CAShapeLayer = { () -> CAShapeLayer in
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.purple.cgColor
        layer.lineWidth = 2
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()
    private let layer5:CAShapeLayer = { () -> CAShapeLayer in
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.green.cgColor
        layer.lineWidth = 2
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()
    private let layer6:CAShapeLayer = { () -> CAShapeLayer in
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.orange.cgColor
        layer.lineWidth = 2
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()
    private let layer7:CAShapeLayer = { () -> CAShapeLayer in
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.gray.cgColor
        layer.lineWidth = 2
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()
    private let layer8:CAShapeLayer = { () -> CAShapeLayer in
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 2
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()
    ///动画
    private lazy var animation = CABasicAnimation(keyPath: "transform.rotation")
    ///定时器
    private var timer:Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() -> () {
        addLayer(subLayer: layer1, startAngle: 0, endAngle: M_PI_4)
        addLayer(subLayer: layer2, startAngle: M_PI_4, endAngle: M_PI_2)
        addLayer(subLayer: layer3, startAngle: M_PI_2, endAngle: M_PI_4*3)
        addLayer(subLayer: layer4, startAngle: M_PI_4*3, endAngle: M_PI)
        addLayer(subLayer: layer5, startAngle: M_PI, endAngle: M_PI_4*5)
        addLayer(subLayer: layer6, startAngle: M_PI_4*5, endAngle: M_PI_2*3)
        addLayer(subLayer: layer7, startAngle: M_PI_2*3, endAngle: M_PI_4*7)
        addLayer(subLayer: layer8, startAngle: M_PI_4*7, endAngle: M_PI*2)
    }
    
    private func addLayer(subLayer:CAShapeLayer,startAngle:Double,endAngle:Double) -> (){
        layer.addSublayer(subLayer)
        subLayer.path = createBezierPath(startAngle: startAngle, endAngle: endAngle).cgPath
    }
    private func createBezierPath(startAngle:Double,endAngle:Double) -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: 10, y: 10), radius: 10, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
    }
    
    func startAnimation() -> (){
        
        animation.fromValue = 0
        animation.toValue = M_PI*2
        animation.duration = 0.5
        animation.repeatCount = MAXFLOAT
        layer.add(animation, forKey: "")
        
        addTimer()
        
    }
    
    func stopAnimation() -> () {
        layer.removeAllAnimations()
        removeTimer()
    }
    ///添加定时器，开始换色
    private func addTimer() -> (){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeColor), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    /// 移除定时器
    private func removeTimer() -> (){
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func changeColor() -> (){
        layer1.strokeColor = randomCorlor()
        layer2.strokeColor = randomCorlor()
        layer3.strokeColor = randomCorlor()
        layer4.strokeColor = randomCorlor()
        layer5.strokeColor = randomCorlor()
        layer6.strokeColor = randomCorlor()
        layer7.strokeColor = randomCorlor()
        layer8.strokeColor = randomCorlor()
    }
    ///随机色
    private func randomCorlor() -> CGColor {
        return UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0).cgColor
    }
    

}
