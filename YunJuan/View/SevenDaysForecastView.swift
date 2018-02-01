//
//  SevenDaysForecastView.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/24.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import UIKit

class SevenDaysForecastView: UIView {
    
    private let titleLabel = UILabel()
    private let line = UIView()
    private let containerView = UIView()
    init() {
        super.init(frame: CGRect.zero)
        
        self.addSubview(titleLabel)
        self.addSubview(line)
        self.addSubview(containerView)
        self.layoutTitle()
    }
    
    
    private func layoutTitle(){
        titleLabel.font = YJFont(18)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "7天预报"
        self.backgroundColor = YJColor(120, 120, 120,0.3)
        line.backgroundColor = UIColor.white
        
        
        titleLabel.mas_updateConstraints { (make) in
            make?.top.equalTo()(self)?.offset()(10)
            make?.left.equalTo()(self)?.offset()(18)
        }
        
        line.mas_updateConstraints { (make) in
            make?.top.equalTo()(titleLabel.mas_bottom)?.offset()(10)
            make?.left.right().equalTo()(self)
            make?.height.equalTo()(1)
        }
        
        containerView.mas_updateConstraints { (make) in
            make?.top.equalTo()(line.mas_bottom)?.offset()(20)
            make?.left.right().equalTo()(self)
            make?.height.greaterThanOrEqualTo()(40)
        }
    }

    override func didMoveToSuperview() {
        self.mas_updateConstraints { (make) in
            make?.bottom.equalTo()(containerView)
        }
    }
    
    public func update(dailyforecasts : [DailyForecast]){
        
        containerView.subviews.forEach { (index) in
            index.removeFromSuperview()
        }
        
        var lastView : UIView?
        for item in dailyforecasts {
            let itemView = DayForecastView(day: item)
            containerView.addSubview(itemView)
            
            itemView.mas_updateConstraints{ (make) in
                make?.left.right().equalTo()(self)
                make?.height.equalTo()(40)
            }
            if lastView == nil {
                itemView.mas_updateConstraints({ (make) in
                    make?.top.equalTo()(containerView)
                })
            }else{
                itemView.mas_updateConstraints({ (make) in
                    make?.top.equalTo()(lastView?.mas_bottom)
                })
            }
            lastView = itemView
        }
        if lastView != nil {
            containerView.mas_updateConstraints({ (make) in
                make?.bottom.equalTo()(lastView?.mas_bottom)
            })
        }else{
            containerView.mas_updateConstraints({ (make) in
                make?.height.greaterThanOrEqualTo()(40)
            })
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
