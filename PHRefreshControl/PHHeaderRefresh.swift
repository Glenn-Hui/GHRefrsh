//
//  PHRefresh.swift
//  自定义刷新控件
//
//  Created by 彭辉 on 2016/11/22.
//  Copyright © 2016年 彭辉. All rights reserved.
//

import UIKit

/// 刷新状态切换的临界点
private let PHHeaderRefreshOffset:CGFloat = 60

class PHHeaderRefresh: PHRefresh {
//MARK: -----------属性------------
    ///指示控件
    private lazy var refreshView:PHHeaderRefreshView = PHHeaderRefreshView()
    
    
    
//MARK: -----------方法------------
    class func headerRefresh(_ target:Any?,_ action:Selector) -> PHHeaderRefresh{
        let headerRefresh=PHHeaderRefresh()
        headerRefresh.addTarget(target, action: action, for: .valueChanged)
        return headerRefresh
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let sv = scrollView else {
            return
        }
        
        let height = -(sv.contentInset.top + sv.contentOffset.y)

        if height<0{
            return
        }
        
        //根据高度设置刷新控件的frame
        self.frame = CGRect(x: 0, y: -height, width: sv.bounds.size.width, height: height)
        
        //判断临界点，只需要判断一次
        if sv.isDragging {
            if height>PHHeaderRefreshOffset && refreshView.refreshState == .Normal{
                refreshView.refreshState = .Pulling
            }else if height <= PHHeaderRefreshOffset && refreshView.refreshState == .Pulling {
                refreshView.refreshState = .Normal
            }
        }else{
            //放手,判断是否超过临界点
            if refreshView.refreshState == .Pulling {
                beginRefresh()
                
                //发送刷新数据事件
                sendActions(for: .allEvents)
            }
        }
        
    }
    
    override func setupUI() -> (){
        
        super.setupUI()
        //设置超出边界不显示
//        clipsToBounds = true
        
        addSubview(refreshView)
        
        //自动布局
        //取消autoresizing
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: PHHeaderRefreshOffset))
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        
    }
    
//MARK:----------外部调用方法-------------
    func beginRefresh() -> () {
        guard let sv = scrollView else {
            return
        }
        if refreshView.refreshState == .WillRefresh {
            return
        }
        refreshView.refreshState = .WillRefresh
        //让整个刷新视图显示出来，通过改变scrollview的contentInset
        var inset = sv.contentInset
        inset.top += PHHeaderRefreshOffset
        
        sv.contentInset = inset
        
    }
    func endRefresh() -> () {
        guard let sv = scrollView else {
            return
        }
        //判断状态，是否是正在刷新，如果是 正在刷新
        if refreshView.refreshState != .WillRefresh {
            return
        }
        refreshView.refreshState = .Normal
        var inset = sv.contentInset
        inset.top -= PHHeaderRefreshOffset
        
        sv.contentInset = inset
    }
    
    
    
}
