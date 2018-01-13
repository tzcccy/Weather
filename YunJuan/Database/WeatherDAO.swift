//
//  WeatherDAO.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/13.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import UIKit

class WeatherDAO: NSObject {
    
    static let shareInstance :WeatherDAO = WeatherDAO()
    
    var dbQueue : FMDatabaseQueue?
    
    override init() {
        super.init()
        self.dbQueue = FMDBManager.shareInstance.dbQueue
    }
    
    
    func insert(weatherJsonStr : String, cityName : String) -> Bool{
        var result : Bool  = true;
        let sql = "INSERT INTO WEATHER(city,weather) VALUES(?,?)"
        dbQueue?.inDatabase({ (db) in
            if db.executeUpdate(sql, withArgumentsIn: [cityName,weatherJsonStr]) {
            }else{
                result = false
            }
        })
        
        return result
    }
    
    func selectCity(city:String) -> Weather?{
        var weather : Weather?
        let sql = "SELECT * FROM WEATHER WHERE city = ?"
        
        dbQueue?.inDatabase({ (db) in
            let result = try? db.executeQuery(sql, values: [city])
            while (result?.next())! {
                let weatherJson = result?.string(forColumn: "weather")
                weather = Weather.deserialize(from: weatherJson)
            }
        })
        return weather
    }
    
    func deleteCity(city:String) -> Bool{
        var result:Bool?
        let sql = "DELETE FROM WEATHER WHERE city = ?"
        dbQueue?.inDatabase({ (db) in
            result = db.executeUpdate(sql, withArgumentsIn: [city])
        })
        return result!
    }
    
    func deleteAll() -> Bool{
        var result : Bool?
        let sql = "DELETE FROM WEATHER"
        dbQueue?.inDatabase({ (db) in
            result = db.executeUpdate(sql, withArgumentsIn: [])
        })
        return result!
    }
    
}
