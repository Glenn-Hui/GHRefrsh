//
//  PHRefresh.swift
//  自定义刷新控件
//
//  Created by 彭辉 on 2016/11/23.
//  Copyright © 2016年 彭辉. All rights reserved.
//

import UIKit
/// 刷新状态
///
/// - Normal: 普通状态
/// - Pulling: 超过临界点，如果放手，开始刷新
/// - WillRefresh: 超过临界点，并且放手
/// - NoMoreData: 加载完全部数据
enum PHRefreshState {
    case Normal
    case Pulling
    case WillRefresh
    case NoMoreData
}
class PHRefresh: UIControl {
//MARK: -----------属性------------
    ///滚动视图的父视图，下拉刷新控件应该适用于UITableView/UICollectionView
    weak var scrollView:UIScrollView?
    
    
    
//MARK: -----------方法------------
    init(){
        super.init(frame: CGRect())
        setupUI()
    }
    //如果使用xib就需实现此方法
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    /// addSubView的时候会调用
    ///
    /// - Parameter newSuperview: 父视图，当父视图被移除的时候为nil
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        //判断父视图的类型
        guard let sv = newSuperview as? UIScrollView else {
            return
        }
        scrollView = sv
        
        //kvo监听父视图的contentOffset,由子视图来实现监听方法
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
    }
    
    ///本视图从父视图移除
    override func removeFromSuperview() {
        //superView还存在
        //移除监听
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        super.removeFromSuperview()
        //superView不存在了
    }
    func setupUI() -> () {
       backgroundColor = UIColor.white
    }
}
