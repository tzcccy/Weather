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
    
    func getWeather(cityName : String, success : @escaping(Weather) -> Void, failure : @escaping(String) -> Void){
        
        //判断上次查询和本次是否相同
        if weather == nil || weather!.city?.location! != cityName{

            let dbweather = dbManager.selectCity(city: cityName)
            //判断数据库中是否存在
            if dbweather == nil {
                networkManager.getWeather(location: cityName, success: { (networkWeather) in
                    success(networkWeather)
                }, failure: { (error) in
                    failure(error)
                })
            }else{
                //检验是否过期
                judgeWeather(weather: weather!, complete: { (newWeather) in
                    self.weather = newWeather
                    success(self.weather!)
                })
            }
            
        }else{
            //上次查询与本次相同，检验缓存结果是否过期
            //TODO:比较当前时间和缓存结果的获取时间，决定
            judgeWeather(weather: weather!, complete: { (newWeather) in
                self.weather = newWeather
                success(self.weather!)
            })
        }
    }
    
    private func judgeWeather(weather : Weather, complete : @escaping(Weather) -> Void) -> (Void){
        let nowDate = Date()
        let weatherDate = weather.createTime
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let hour = gregorian!.components(NSCalendar.Unit.hour, from: weatherDate, to: nowDate, options: NSCalendar.Options.init(rawValue: 0)).hour!
        if hour > MaxUpdateHour {
            //超过时间了，需要更新
            networkManager.getWeather(location: weather.city!.location!, success: { (networkWeather) in
                //先更新数据库
                let _ = self.updateDatabase(weather: networkWeather)
                //提醒用户更新
                complete(networkWeather)
            }, failure: { (error) in
                complete(weather)       //这种情况可能是网络错误,那就不更新
            })
        }else{
            complete(weather)
        }
    }
    
    func updateDatabase(weather : Weather?) -> Bool{
        if weather == nil {
            return false
        }
        return dbManager.updateWeather(weather: weather!)
    }
    
    /// 增加一个天气纪录
    ///
    /// - Parameters:
    ///   - cityName: 要增加的城市名称
    ///   - success: 成功，返回对应城市的天气，并更新数据库
    ///   - failure: 失败，找不到城市，或者，数据库中已有
    func addCityWeather(cityName : String, success : @escaping(Weather) -> Void, failure:@escaping(String) -> ()){
        	self.getWeather(cityName: cityName, success: { (weather) in
                
                if self.dbManager.insert(weatherJsonStr: weather.toJSONString(), cityName: weather.city?.location) {
                    success(weather)
                }else{
                    failure(ErrorMsg)
                }
            }) { (error) in
                failure(error)
            }
    }
    
    /// 增加一条天气纪录
    ///
    /// - Parameters:
    ///   - weather: 要增加的天气数据
    ///   - success: 成功
    ///   - failure: 失败
    func addCityWeather(weather : Weather, success : (Weather)->Void, failure:(String)->Void){
        if self.dbManager.insert(weatherJsonStr: weather.toJSONString(), cityName: weather.city?.location) {
            success(weather)
        }else{
            failure(ErrorMsg)
        }
    }
    
    func getWeatherList(success : @escaping([Weather])->Void) -> ([Weather]){
        var arr :[Weather] = self.dbManager.selectAll()

        //在这里对每一个检验是否过期
        DispatchQueue.global().async {
            for (index,item) in arr.enumerated() {
                self.judgeWeather(weather: item, complete: { (weather) in
                    arr[index] = weather
                })
            }
            DispatchQueue.main.async {
                success(arr)
            }
        }
        
        
        return arr
    }
    
    func deleteWeather(weather : Weather) -> Bool {
        
        return self.dbManager.deleteCity(city: weather.city?.location)
    }
    
}
