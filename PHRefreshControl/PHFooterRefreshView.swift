//
//  PHFooterRefreshView.swift
//  自定义刷新控件
//
//  Created by 彭辉 on 2016/11/23.
//  Copyright © 2016年 彭辉. All rights reserved.
//

import UIKit

class PHFooterRefreshView: UIView {
    var refreshState:PHRefreshState = .Normal{
        didSet{
            switch refreshState {
            case .Normal:
                tipLabel.isHidden = false
                tipLabel.text = "上拉刷新"
                indicator.stopAnimating()
            case .Pulling:
                tipLabel.text = "释放刷新"
                indicator.stopAnimating()
            case .WillRefresh:
                tipLabel.isHidden = true
                indicator.startAnimating()
            case .NoMoreData:
                tipLabel.isHidden = false
                tipLabel.text = "已加载全部数据"
                indicator.stopAnimating()
            }
        }
    }
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    class func footerView() -> PHFooterRefreshView{
        return Bundle.main.loadNibNamed("PHFooterRefreshView", owner: nil, options: nil)?.last as! PHFooterRefreshView
    }
}
