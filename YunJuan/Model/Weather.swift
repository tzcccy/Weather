//
//  Weather.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/13.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import HandyJSON

enum WeatherStatus: String, HandyJSONEnum{
    case ok = "ok"
    case invalidKey = "invalid key"
    case unknowLocation = "unknown location"
    case noData = "no data for this location"
    case noMoreRequest = "no more requests"
    case paramInvalid = "param invalid"
    case tooFast = "too fast"
    case dead = "dead"
    case permissionDenied = "permission denied"
    case signError = "sign error"
    
}

class Weather: HandyJSON {
    
    var status : WeatherStatus?
    var city : City?
    var dailyForecast : [DailyForecast]?
    var hourly : [HourlyWeather]?
    var lifestyle : [LifeStyle]?
    var nowWeather : NowWeather?
    var update : Update?
    
    var createTime : Date = Date()
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.city <-- "basic"
        mapper <<<
            self.dailyForecast <-- "daily_forecast"
        mapper <<<
            self.hourly <-- "hourly"
        mapper <<<
            self.lifestyle <-- "lifestyle"
        mapper <<<
            self.nowWeather <-- "now"
        mapper <<<
            self.update <-- "update"
        mapper <<<
            self.status <-- "status"
    }
    
    required init(){
    }

}
