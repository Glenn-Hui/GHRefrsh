//
//  PHRefreshView.swift
//  自定义刷新控件
//
//  Created by 彭辉 on 2016/11/22.
//  Copyright © 2016年 彭辉. All rights reserved.
//

import UIKit

class PHHeaderRefreshView: UIView {
    ///刷新状态
    /**
     UIView封装的旋转动画：默认为顺时针、就近原则、要想实现同方向旋转，需调整非常小的数字
     */
    
    var refreshState:PHRefreshState = .Normal{
        didSet{
            switch refreshState {
            case .Normal:
                circleView.isHidden = true
                tipIcon.isHidden = false
                circleView.stopAnimation()
                UIView.animate(withDuration: 0.25, animations: { 
                    self.tipIcon.transform = CGAffineTransform.identity
                })
            case .Pulling:
                circleView.isHidden = true
                circleView.stopAnimation()
                UIView.animate(withDuration: 0.25, animations: {
                    self.tipIcon.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI-0.001))
                })
            case .WillRefresh:
                //隐藏提示图标
                circleView.isHidden = false
                circleView.startAnimation()
                tipIcon.isHidden = true
                
            case .NoMoreData: break
            }
        }
    }
    /// 箭头
    private var tipIcon: UIImageView = UIImageView(image: UIImage(named: "PHRefresh_arrow"))
    private var circleView:PHRefreshCircleView = PHRefreshCircleView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() -> () {
        addSubview(tipIcon)
        
        addSubview(circleView)
        
        circleView.isHidden = true
        
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraint(NSLayoutConstraint(item: tipIcon, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: tipIcon, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: tipIcon, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 30))
        addConstraint(NSLayoutConstraint(item: tipIcon, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 30))
        
        addConstraint(NSLayoutConstraint(item: circleView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: circleView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: circleView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: circleView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 20))
        
        
    }
}
