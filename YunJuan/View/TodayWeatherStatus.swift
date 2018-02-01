//
//  TodayWeatherStatus.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/18.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import UIKit

class TodayWeatherStatus: UIView {


    
    
    
    private let publishLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let statusImage = UIImageView()
    private let weatherStatusLabel = UILabel()
    private let wndDirStatusLabel = UILabel()
    private let wndPowerStatus = UILabel()
    private let humStatusLabel = UILabel()
    private let arrowImage = UIImageView(image: #imageLiteral(resourceName: "ic_goto"))
    private let detailButton = UIButton()
    
    private let line = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubViews()
    }
    
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setSubViews(){
        
        statusImage.contentMode = UIViewContentMode.scaleAspectFill
        
        publishLabel.font = YJFont(14)
        publishLabel.textColor = UIColor.white
        
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 52)
        temperatureLabel.textColor = UIColor.white
        
        weatherStatusLabel.font = YJFont(18)
        wndDirStatusLabel.font = YJFont(18)
        wndPowerStatus.font = YJFont(18)
        humStatusLabel.font = YJFont(18)
        
        weatherStatusLabel.textColor = UIColor.white
        wndDirStatusLabel.textColor = UIColor.white
        wndPowerStatus.textColor = UIColor.white
        humStatusLabel.textColor = UIColor.white
        
        line.backgroundColor = UIColor.white
        
        self.addSubview(publishLabel)
        self.addSubview(temperatureLabel)
        self.addSubview(statusImage)
        self.addSubview(weatherStatusLabel)
        self.addSubview(wndDirStatusLabel)
        self.addSubview(wndPowerStatus)
        self.addSubview(humStatusLabel)
        self.addSubview(arrowImage)
        self.addSubview(detailButton)
        self.addSubview(line)

    }
    
    
    override func layoutSubviews() {
        publishLabel.mas_updateConstraints{ (make) in
            make?.top.equalTo()(self.mas_top)?.offset()(80)
            make?.right.equalTo()(self.mas_right)?.offset()(-20)
        }
        
        statusImage.mas_updateConstraints { (make) in
            make?.bottom.equalTo()(self)?.offset()(-30)
            make?.left.equalTo()(self)?.offset()(2)
            make?.width.height().mas_equalTo()(30)
        }
        
        
        weatherStatusLabel.mas_updateConstraints { (make) in
            make?.centerY.equalTo()(statusImage)
            make?.left.equalTo()(statusImage.mas_right)?.offset()(10)
        }
        
        line.mas_updateConstraints { (make) in
            make?.centerY.equalTo()(weatherStatusLabel)
            make?.left.equalTo()(weatherStatusLabel.mas_right)?.offset()(8)
            make?.height.mas_equalTo()(25)
            make?.width.mas_equalTo()(0.7)
        }
        
        wndDirStatusLabel.mas_updateConstraints { (make) in
            make?.centerY.equalTo()(line)
            make?.left.equalTo()(line.mas_right)?.offset()(8)
        }
        
        wndPowerStatus.mas_updateConstraints { (make) in
            make?.centerY.equalTo()(wndDirStatusLabel)
            make?.left.equalTo()(wndDirStatusLabel.mas_right)?.offset()(10)
        }
        
        humStatusLabel.mas_updateConstraints { (make) in
            make?.centerY.equalTo()(wndPowerStatus)
            make?.left.equalTo()(wndPowerStatus.mas_right)?.offset()(10)
        }
        
        arrowImage.mas_updateConstraints { (make) in
            make?.centerY.equalTo()(humStatusLabel)
            make?.left.equalTo()(humStatusLabel.mas_right)?.offset()(10)
            make?.width.height().mas_equalTo()(25)
        }
        
        detailButton.mas_updateConstraints { (make) in
            make?.left.top().bottom().equalTo()(weatherStatusLabel)
            make?.right.equalTo()(arrowImage)
        }
        
        temperatureLabel.mas_updateConstraints { (make) in
            make?.bottom.equalTo()(statusImage.mas_top)?.offset()(-30)
            make?.left.equalTo()(self)?.offset()(28)
        }
    }
    
    
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents){
        self.detailButton.addTarget(target, action: action, for: controlEvents)
    }
    
    
    
    /// 更新数据
    ///
    /// - Parameter weather: 天气
    func updateWeather(weather : Weather){
        
        let transform = DateFormatter()
        transform.dateFormat = "HH:mm"
        publishLabel.text = "发布时间：" + transform.string(from: weather.createTime)
        temperatureLabel.text = (weather.nowWeather?.tmp ?? "未知") + "°"
        
        statusImage.sd_setImage(with: URL(string: "https://cdn.heweather.com/cond_icon/" + (weather.nowWeather?.cond_code ?? "999") + ".png") , completed: nil)
        
        weatherStatusLabel.text = weather.nowWeather?.cond_txt ?? "未知"
        
        wndDirStatusLabel.text = weather.nowWeather?.wind_dir ?? ""
        
        wndPowerStatus.text = weather.nowWeather?.wind_sc ?? ""
        let hum = weather.nowWeather?.hum
        if (hum != nil) {
            humStatusLabel.text = "湿度" + hum! + "%"
        }else{
            humStatusLabel.text = ""
        }
        
        
        
        
        setNeedsLayout()
    }
    
    
    
    
}
