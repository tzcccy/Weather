//
//  NowWeather.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/13.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import HandyJSON

class NowWeather: HandyJSON {

    var fl : String?	//体感温度，默认单位：摄氏度	23
    var tmp : String?	//温度，默认单位：摄氏度	21
    var cond_code : String?	//实况天气状况代码	100
    var cond_txt : String?	//实况天气状况代码	晴
    var wind_deg : String?	//风向360角度	305
    var wind_dir : String?	//风向	西北
    var wind_sc : String?	//风力	3-4
    var wind_spd : String?	//风速，公里/小时	15
    var hum : String?	//相对湿度	40
    var pcpn : String?	//降水量	0
    var pres : String?	//大气压强	1020
    var vis : String?	//能见度，默认单位：公里	10
    var cloud : String?	//云量	23
    
    required init(){}
}
