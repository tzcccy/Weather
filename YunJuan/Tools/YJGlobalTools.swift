//
//  YJGlobalTools.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/14.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import UIKit

func getDefaultCity() -> String?{
    return UserDefaults.standard.string(forKey: DefaultCityName)
}

func setDefaultCity(city : String) {
    UserDefaults.standard.set(city, forKey: DefaultCityName)
}

func YJLog<T>(_ message : T, filename : String = #file, methodName: String = #function, lineNumber: Int = #line){
    #if DEBUG
        let logStr : String = (filename as NSString).pathComponents.last!.replacingOccurrences(of: "swift", with: "")
        print("类：\(logStr) 方法：\(methodName) 行：[\(lineNumber)] 数据：\(message)")
    #endif
}


func YJFont(_ size : CGFloat) ->UIFont{
    return UIFont.systemFont(ofSize: size)
}

func choseBackImage(condCode : String) -> UIImage{
    let code = Int(condCode)!
    if code == 100{
        return #imageLiteral(resourceName: "ic_background_sun")
    }
    if code >= 101 && code <= 103 {
        return #imageLiteral(resourceName: "ic_background_cloud")
    }
    if code == 104 {
        return #imageLiteral(resourceName: "ic_background_yin")
    }
    if code >= 200 && code <= 213 {
        return #imageLiteral(resourceName: "ic_background_wind")
    }
    if code >= 300 && code <= 313 {
        return #imageLiteral(resourceName: "ic_background_rain")
    }
    if code >= 400 && code < 500 {
        return #imageLiteral(resourceName: "ic_background_snow")
    }
    if code >= 500 && code < 600 {
        return #imageLiteral(resourceName: "ic_background_haze")
    }
    return #imageLiteral(resourceName: "ic_background_cloud")
}

func YJColor(_ r:CGFloat,_ g : CGFloat,_ b : CGFloat, _ a : CGFloat) -> UIColor{
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
}


func dayOfWeek(date : Date) -> String{
    let interval = date.timeIntervalSince1970
    let days = Int(interval / 86400)
    switch days % 7 {
    case 1:
        return "星期一"
    case 2:
        return "星期二"
    case 3:
        return "星期三"
    case 4:
        return "星期四"
    case 5:
        return "星期五"
    case 6:
        return "星期六"
    case 0:
        return "星期日"
    default:
        return ""
    }
}
