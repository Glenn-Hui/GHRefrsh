//
//  PHFooterRefresh.swift
//  自定义刷新控件
//
//  Created by 彭辉 on 2016/11/23.
//  Copyright © 2016年 彭辉. All rights reserved.
//

import UIKit
/// 刷新状态切换的临界点
private let PHHeaderRefreshOffset:CGFloat = 40

class PHFooterRefresh: PHRefresh {
//MARK: ----------------属性----------------
    private lazy var footerView:PHFooterRefreshView = PHFooterRefreshView.footerView()
    
    private var refreshState:PHRefreshState = .Normal {
        didSet{
            footerView.refreshState = refreshState
        }
    }
//MARK: ----------------方法----------------
    class func footerRefresh(_ target:Any?,_ action:Selector) -> PHFooterRefresh{
        let footerRefresh=PHFooterRefresh()
        footerRefresh.addTarget(target, action: action, for: .valueChanged)
        return footerRefresh
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let sv = scrollView else {
            return
        }
        
        if sv.contentOffset.y<0 {
            return
        }
        
        let y = sv.contentSize.height
        let height = sv.contentOffset.y+sv.bounds.size.height-sv.contentInset.bottom-sv.contentSize.height
        
        if height<0{
            return
        }
        
        frame = CGRect(x: 0, y: y, width: sv.frame.size.width, height: height)
        
        if sv.isDragging {//拖拽的时候
            
            //下拉高度大于40并且刷新状态为normal时
            if height>PHHeaderRefreshOffset && footerView.refreshState == .Normal  {
                
                refreshState = .Pulling
                
            }else if height<PHHeaderRefreshOffset && footerView.refreshState == .Pulling {
                //下拉高度小于40并且刷新状态为pulling时
                refreshState = .Normal
                
            }
            
        }else{//释放的时候
            if footerView.refreshState == .Pulling || footerView.refreshState == .NoMoreData {
                beginRefresh()
                
                sendActions(for: .allEvents)
                
            }
        }
        
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        addSubview(footerView)
        
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: PHHeaderRefreshOffset))
        addConstraint(NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
    
    }
//MARK:----------外部调用方法-------------
    private func beginRefresh() -> () {
        guard let sv = scrollView else {
            return
        }
        if footerView.refreshState == .WillRefresh {
            return
        }
        
        footerView.refreshState = .WillRefresh
        
        var inset = sv.contentInset
        inset.bottom += 40
        sv.contentInset = inset
        
    }
    func endRefresh() -> () {
        guard let sv = scrollView else {
            return
        }
        
        if footerView.refreshState != .WillRefresh {
            return
        }
        
        footerView.refreshState = .Normal
        
        var inset = sv.contentInset
        inset.bottom -= 40
        sv.contentInset = inset
        
    }
    ///没有更多数据
//    func endRefreshWithNoMoreData() -> () {
//        guard let sv = scrollView else {
//            return
//        }
//        if footerView.refreshState == .NoMoreData{
//            return
//        }
//        
//        refreshState = .NoMoreData
//        
////        var inset = sv.contentInset
////        inset.bottom += 40
////        sv.contentInset = inset
//    }
}
