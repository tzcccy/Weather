//
//  HourlyWeatherView.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/19.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import UIKit

class HourlyWeatherView: UIView {
    
    private let titleLabel = UILabel()
    private let line = UIView()
    private let scrollView = UIScrollView()
    private var containerView = UIView()
    init() {
        
        super.init(frame: CGRect.zero)
        
        self.addSubview(titleLabel)
        self.addSubview(line)
        self.addSubview(scrollView)
        self.scrollView.addSubview(containerView)
        self.layoutTitle()
    }
    
    /// Call this func when update weather
    ///
    /// - Parameter weather: new weather
    public func updateWeather(weather : Weather){
        self.layoutViewsWithWeather(weather)
    }
    
    
/*******************private function************************************/
    
    private func layoutTitle(){
        titleLabel.font = YJFont(18)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "24小时预报"
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
        
        containerView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.scrollView)
            make?.height.equalTo()(self.scrollView)
        }
        
        scrollView.mas_updateConstraints { (make) in
            make?.top.equalTo()(line.mas_bottom)?.offset()(20)
            make?.left.right().equalTo()(self)
            make?.height.greaterThanOrEqualTo()(80)
        }
    }
    
    

    override
    func didMoveToSuperview() {
        self.mas_updateConstraints { (make) in
            make?.bottom.equalTo()(self.scrollView)
        }
    }
    
    private func layoutViewsWithWeather(_ weather : Weather){
        //remove last
        containerView.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        
        var lastView : UIView?
        for item in weather.hourly! {
            let hourlyView = HourForecastView(hourWeather: item)
            containerView.addSubview(hourlyView)
            hourlyView.mas_updateConstraints({ (make) in
                make?.top.equalTo()(containerView)
                make?.width.mas_equalTo()(100)
                if(lastView != nil){
                    make?.left.equalTo()(lastView?.mas_right)
                }else{
                    make?.left.equalTo()(containerView)
                }
            })
            lastView = hourlyView
        }
        if lastView != nil {
            containerView.mas_updateConstraints { (make) in
                make?.right.equalTo()(lastView?.mas_right)
            }
            scrollView.mas_updateConstraints({ (make) in
                make?.bottom.equalTo()(lastView?.mas_bottom)
            })
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
