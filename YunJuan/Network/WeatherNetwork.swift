//
//  WeatherNetwork.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/13.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import UIKit

class WeatherNetwork: NSObject {
    static let shareInstance:WeatherNetwork = WeatherNetwork()
    
    
    func getWeather( location:String, success: @escaping(Weather?) -> (), failure: @escaping(String) -> ()) -> Void
    {
        let networkManager = YJNetworkTool.shareManager
        let param = ["location":location,"key":"2e59aaf980bd445d9e42dd1492e04bcf"]
        networkManager.request(method: .Get, urlString: "https://free-api.heweather.com/s6/weather", parameters: param as AnyObject, success: { (dic) in
            
            //先做json to model 的转换
            let weatherArray = [Weather].deserialize(from: (dic["HeWeather6"] as! [Any]))
            let weather:Weather? = weatherArray?[0]
            if weather == nil {
                failure("无法访问")
                return
            }
            if weather!.status == WeatherStatus.ok {
                success(weather)
                return
            }
            
            failure(weather!.status!.rawValue)
            
        }) { (error) in
            if error == nil {
                failure("无法访问")
            }else{
                failure(error!.localizedDescription)
            }
            
        }
    }
    
}
