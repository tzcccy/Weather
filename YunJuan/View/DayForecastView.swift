//
//  DayForecastView.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/24.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import UIKit

class DayForecastView: UIView {

    
    private let dayforecast : DailyForecast
    private let date = UILabel()
    private let weekday = UILabel()
    private let weatherImage = UIImageView()
    private let weatherLabel = UILabel()
    private let lowTemperature = UILabel()
    private let heighTemperature = UILabel()
    
    init(day:DailyForecast) {
        dayforecast = day
        super.init(frame: CGRect.zero)
        
        self.addSubview(date)
        self.addSubview(weekday)
        self.addSubview(weatherImage)
        self.addSubview(weatherLabel)
        self.addSubview(lowTemperature)
        self.addSubview(heighTemperature)
        
        self.initsubViews()
    }
    
    override func layoutSubviews() {
        date.mas_updateConstraints { (make) in
            make?.centerY.equalTo()(self)
            make?.left.equalTo()(self)?.offset()(28)
        }
        
        weekday.mas_updateConstraints { (make) in
            make?.centerY.equalTo()(self)
            //make?.left.equalTo()(date.mas_right)?.offset()(20)
        }
        
        weatherImage.mas_updateConstraints { (make) in
            make?.width.height().equalTo()(25)
            //make?.left.equalTo()(weekday.mas_right)?.offset()(20)
            make?.centerY.equalTo()(self)
        }
        
        weatherLabel.mas_updateConstraints { (make) in
            make?.centerY.equalTo()(self)
            //make?.left.equalTo()(weatherImage.mas_right)?.offset()(20)
        }
        
        heighTemperature.mas_updateConstraints { (make) in
            make?.centerY.equalTo()(self)
            //make?.right.equalTo()(self)?.offset()(-20)
        }
        
        lowTemperature.mas_updateConstraints { (make) in
            make?.centerY.equalTo()(self)
            //make?.right.equalTo()(heighTemperature.mas_left)?.offset()(-30)
        }
        
        
    }
    
    private func initsubViews(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let week : Date = formatter.date(from: dayforecast.date!)!
        formatter.dateFormat = "MM-dd"
        date.font = YJFont(14)
        date.textColor = UIColor.white
        date.text = formatter.string(from: week)
        
        
        
        weekday.text = dayOfWeek(date: week)
        weekday.font = YJFont(14)
        weekday.textColor = UIColor.white
        
        
        weatherImage.sd_setImage(with: URL(string: "https://cdn.heweather.com/cond_icon/" + (dayforecast.cond_code_d ?? "999") + ".png") , completed: nil)
        weatherImage.contentMode = UIViewContentMode.scaleAspectFit
        
        weatherLabel.text = dayforecast.cond_txt_d!
        weatherLabel.font = YJFont(14)
        weatherLabel.textColor = UIColor.white
        
        lowTemperature.text = dayforecast.tmp_min! + "°"
        lowTemperature.font = YJFont(14)
        lowTemperature.textColor = UIColor.white
        
        heighTemperature.text = dayforecast.tmp_max! + "°"
        heighTemperature.font = YJFont(14)
        heighTemperature.textColor = UIColor.white
        let arr : NSMutableArray = NSMutableArray()
        arr.add(date)
        arr.add(weekday)
        arr.add(weatherImage)
        arr.add(weatherLabel)
        arr.add(lowTemperature)
        arr.add(heighTemperature)
        arr.mas_distributeViews(along: MASAxisType.horizontal, withFixedSpacing: 5, leadSpacing: 0, tailSpacing: 0)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
