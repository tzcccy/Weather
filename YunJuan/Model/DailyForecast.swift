//
//  DailyForecast.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/13.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import HandyJSON

class DailyForecast: HandyJSON {

    /// 预测时间 YYYY-MM-DD
    var date : String?
    /// 日出时间 HH：mm
    var sr : String?
    /// 日落时间 HH:mm
    var ss : String?
    /// 月出时间
    var mr : String?
    /// 月落时间
    var ms : String?
    /// 最高温度
    var tmp_max : String?
    /// 最低温度
    var tmp_min : String?
    /// 白天天气代码
    var cond_code_d : String?
    /// 晚上天气代码
    var cond_code_n	: String?
    /// 白天天气描述
    var cond_txt_d	: String?
    /// 晚上天气描述
    var cond_txt_n	: String?
    /// 风向角度
    var wind_deg	: String?
    /// 风向
    var wind_dir	: String?
    /// 风力
    var wind_sc		: String?
    /// 风速
    var wind_spd	: String?
    /// 相对湿度
    var hum	    	: String?
    /// 降雨量
    var pcpn	: String?
    /// 降雨概率
    var pop		: String?
    /// 大气压强
    var pres	: String?
    /// 紫外线强度
    var uv_index	: String?
    /// 能见度
    var vis	: String?
    required init(){}
}
