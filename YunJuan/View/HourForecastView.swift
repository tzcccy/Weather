//
//  HourForecastView.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/19.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import UIKit

class HourForecastView: UIView {

    
    
    
    private let hourWeather : HourlyWeather
    private let timeLabel = UILabel()
    private let weatherImage = UIImageView()
    private let temperatureLabel = UILabel()
    private let weatherStatusLabel = UILabel()
    private let wndDirLabel = UILabel()
    private let wndPowerLabel = UILabel()
    
    
    
    
    
    
    init(hourWeather: HourlyWeather) {
        
        self.hourWeather = hourWeather

        
        super.init(frame: CGRect.zero)
        
        self.addSubview(timeLabel)
        self.addSubview(weatherImage)
        self.addSubview(temperatureLabel)
        self.addSubview(weatherStatusLabel)
        self.addSubview(wndDirLabel)
        self.addSubview(wndPowerLabel)
        
        self.initSubViews()
    }
    override
    func layoutSubviews() {
        
        timeLabel.mas_updateConstraints { (make) in
            make?.top.equalTo()(self)
            make?.centerX.equalTo()(self)
        }
        
        weatherImage.mas_updateConstraints { (make) in
            make?.centerX.equalTo()(self)
            make?.top.equalTo()(timeLabel.mas_bottom)?.offset()(10)
            make?.width.height().mas_equalTo()(30)
        }
        
        temperatureLabel.mas_updateConstraints { (make) in
            make?.centerX.equalTo()(self)
            make?.top.equalTo()(weatherImage.mas_bottom)?.offset()(10)
        }
        
        weatherStatusLabel.mas_updateConstraints { (make) in
            make?.centerX.equalTo()(self)
            make?.top.equalTo()(temperatureLabel.mas_bottom)?.offset()(10)
        }
        
        wndDirLabel.mas_updateConstraints { (make) in
            make?.centerX.equalTo()(self)
            make?.top.equalTo()(weatherStatusLabel.mas_bottom)?.offset()(10)
        }
        
        wndPowerLabel.mas_updateConstraints { (make) in
            make?.centerX.equalTo()(self)
            make?.top.equalTo()(wndDirLabel.mas_bottom)?.offset()(10)
            make?.height.greaterThanOrEqualTo()(20)
        }
    }
    
    override
    func didMoveToSuperview() {
        self.mas_updateConstraints { (make) in
            make?.bottom.equalTo()(wndPowerLabel.mas_bottom)
            make?.top.equalTo()(timeLabel)
        }
    }
    
    private func initSubViews(){
        timeLabel.font = UIFont.boldSystemFont(ofSize: 13)
        timeLabel.textColor = UIColor.white
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = formatter.date(from: hourWeather.time!)
        formatter.dateFormat = "HH:mm"
        timeLabel.text = formatter.string(from: date!)
        
        
        weatherImage.sd_setImage(with: URL(string: "https://cdn.heweather.com/cond_icon/" + (hourWeather.cond_code ?? "999") + ".png"), completed: nil)
        
        temperatureLabel.font = YJFont(13)
        temperatureLabel.textColor = UIColor.white
        temperatureLabel.text = hourWeather.tmp! + "°"
        
        weatherStatusLabel.font = YJFont(15)
        weatherStatusLabel.textColor = UIColor.white
        weatherStatusLabel.text = hourWeather.cond_txt
        
        wndDirLabel.font = YJFont(15)
        wndDirLabel.textColor = UIColor.white
        wndDirLabel.text = hourWeather.wind_dir
        
        wndPowerLabel.font = YJFont(15)
        wndPowerLabel.textColor = UIColor.white
        wndPowerLabel.text = hourWeather.wind_sc
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
