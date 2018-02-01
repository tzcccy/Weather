//
//  WeatherController.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/14.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import UIKit

class WeatherController: UIViewController {

    private var cityNameLabel : UILabel?
    private var backImageView = UIImageView()
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    
    
    private let weatherService = YJWeatherService.shareInstance
    
    private let todayStatusView = TodayWeatherStatus()
    private let hourlyWeatherView = HourlyWeatherView()
    private let sevenDaysForecast = SevenDaysForecastView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setNavigationBarType()
        setNavigationLeftBarButton()
        setNavigationRightBarButton()
        setSubviewLayer()
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: Notification.Name.init(WeatherUpdateNotification), object: nil)
        
        defaultCity()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:Super Class Function
    
    @objc func update(_ notification : Notification){
        let dic : Dictionary? = notification.userInfo
        if dic == nil {
            assert(false, "天气为空")
        }
        let city : String = dic!["city"] as! String
        weatherService.getWeather(cityName: city, success: { (weather) in
            self.updateWeather(weather)
            //TODO:在这里需要更新背景
            self.cityNameLabel?.text = city
            self.backImageView.image = choseBackImage(condCode: weather.nowWeather!.cond_code!)
        }) { (error) in
            YJLog(error)
        }
    }
    
    //MARK:Public Function
    private func updateWeather(_ weather : Weather){
        todayStatusView.updateWeather(weather: weather)
        hourlyWeatherView.updateWeather(weather: weather)
        sevenDaysForecast.update(dailyforecasts: weather.dailyForecast!)
    }
    

    //MARK:Private Function
    /// 设置
    private func setNavigationBarType(){
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.clipsToBounds = true
        let rect = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64)
        
        
        UIGraphicsBeginImageContext(rect.size);
        
        let context = UIGraphicsGetCurrentContext();
        
        context!.setFillColor(UIColor.clear.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //UIImage *image =;/**<生成图片*/
        
        UIGraphicsGetCurrentContext();
        self.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
    }
    
    private func setNavigationLeftBarButton(){
        let leftBarButton = UIButton()
        leftBarButton.addTarget(self, action: #selector(clickChoseCityBtn), for: UIControlEvents.touchUpInside)
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ic_home"))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        leftBarButton.addSubview(imageView)
        cityNameLabel = UILabel()
        cityNameLabel?.text = "未知"
        cityNameLabel?.textColor = UIColor.white
        leftBarButton.addSubview(cityNameLabel!)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        
        imageView.mas_makeConstraints { (make) in
            make?.left.equalTo()(leftBarButton)
            make?.top.bottom().equalTo()(leftBarButton)
            make?.width.mas_equalTo()(25)
        }
        
        cityNameLabel!.mas_makeConstraints { (make) in
            make?.left.equalTo()(imageView.mas_right)?.offset()(10)
            make?.top.bottom().equalTo()(imageView)
        }
        leftBarButton.mas_makeConstraints { (make) in
            make?.right.equalTo()(cityNameLabel)
        }
        
    }
    
    
    private func setNavigationRightBarButton(){
        let rightBarButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        rightBarButton.setImage(#imageLiteral(resourceName: "ic_setting"), for: UIControlState.normal)
        rightBarButton.addTarget(self, action: #selector(clickSetting), for: UIControlEvents.touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
    }
    
    private func setSubviewLayer(){
        self.view.addSubview(backImageView)
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        containerView.addSubview(todayStatusView)
        containerView.addSubview(hourlyWeatherView)
        containerView.addSubview(sevenDaysForecast)
        
        
        
        backImageView.mas_updateConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
        
        scrollView.mas_updateConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
        
        
        
        containerView.mas_updateConstraints { (make) in
            make?.edges.equalTo()(scrollView)
            make?.width.equalTo()(scrollView.mas_width)
            make?.bottom.equalTo()(sevenDaysForecast)
        }
        
        todayStatusView.mas_updateConstraints { (make) in
            make?.left.right().equalTo()(containerView)
            make?.top.equalTo()(containerView)//?.offset()(80)
            make?.height.equalTo()(self.view)
        }
        
        hourlyWeatherView.mas_updateConstraints { (make) in
            make?.top.equalTo()(todayStatusView.mas_bottom)
            make?.left.right().equalTo()(containerView)
        }
        
        sevenDaysForecast.mas_updateConstraints { (make) in
            make?.top.equalTo()(hourlyWeatherView.mas_bottom)?.offset()(10)
            make?.left.right().equalTo()(containerView)
        }
        
        
    }
    
    private func defaultCity(){
        let city = "绵阳"
        NotificationCenter.default.post(name: NSNotification.Name.init(WeatherUpdateNotification), object: nil, userInfo: ["city":city])
    }
    //MARK:按钮的点击事件在下面
    
    @objc private func clickSetting(){
        YJLog("点击了设置")
    }
    
    @objc private func clickChoseCityBtn(){
        YJLog("点击了选择城市")
    }
    
}
