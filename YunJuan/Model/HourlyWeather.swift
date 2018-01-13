//
//  HourlyWeather.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/13.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import HandyJSON

class HourlyWeather: HandyJSON {

    var time : String?  //	预报时间，格式yyyy-MM-dd hh:mm	2013-12-30 13:00
    var tmp : String?  //	温度	2
    var cond_code : String?  //	天气状况代码	101
    var cond_txt : String?  //	天气状况代码	多云
    var wind_deg : String?  //	风向360角度	290
    var wind_dir : String?  //	风向	西北
    var wind_sc : String?  //	风力	3-4
    var wind_spd : String?  //	风速，公里/小时	15
    var hum : String?  //	相对湿度	30
    var pres : String?  //	大气压强	1030
    var dew : String?  //	露点温度	12
    var cloud : String?  //	云量	23
    
    required init(){}
}
