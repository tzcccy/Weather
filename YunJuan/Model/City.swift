//
//  City.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/13.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import HandyJSON

class City: HandyJSON{
    /// 地区／城市名称
    var location : String?
    /// 城市id
    var cid : String?
    /// 城市维度
    var lon : String?
    /// 城市经度
    var lat : String?
    /// 上级城市
    var parent_city : String?
    /// 行政区域
    var admin_area : String?
    /// 国家名称
    var cnty : String?
    /// 时区
    var tz : String?
    
    
    required init(){}
}
