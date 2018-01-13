//
//  LifeStyle.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/13.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import HandyJSON

enum LifeStyleType:String,HandyJSONEnum{
    case conf = "comf"
    case cw = "cw"
    case drsg = "drsg"
    case flu = "flu"
    case sport = "sport"
    case trav = "trav"
    case uv = "uv"
    case air = "air"
}

class LifeStyle: HandyJSON {

    var brf:String? //	生活指数简介
    var txt:String? //	生活指数详细描述
    var type:LifeStyleType? //	生活指数类型 comf：舒适度指数、cw：洗车指数、drsg：穿衣指数、flu：感冒指数、sport：运动指数、trav：旅游指数、uv：紫外线指数、air：空气污染扩散条件指数
    
    required init(){}
}
