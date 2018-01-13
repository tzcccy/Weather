//
//  YJWeatherService.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/13.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import UIKit

class YJWeatherService: NSObject {
    static let shareInstance : YJWeatherService = YJWeatherService()
    let dbManager : WeatherDAO = WeatherDAO.shareInstance
    let networkManager : WeatherNetwork = WeatherNetwork.shareInstance
    
    var weather : Weather?
    
    func getWeather(cityName : String, complete : @escaping(Weather?) -> Void) -> Void{
        if weather == nil || weather!.city!.location! != cityName{
            //上次查询与本次不符，或者没有缓存纪录
            //在数据库中查询
            weather = dbManager.selectCity(city: cityName)
            if weather == nil {
                //数据库中不存在，去网络查询
                networkManager.getWeather(location: cityName, success: { (networkWeather) in
                    complete(networkWeather)
                }, failure: { (error) in
                    complete(nil)       //这种情况可能是网络错误，直接提醒用户查询失败，是否重查
                })
            }else{
                //检验是否过期
            }
            
        }else{
            //上次查询与本次相同，检验缓存结果是否过期
            //TODO:比较当前时间和缓存结果的获取时间，决定
        }
    }
    
    
    
    
}
