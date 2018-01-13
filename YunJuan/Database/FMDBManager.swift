//
//  FMDBManager.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/13.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import UIKit

class FMDBManager: NSObject {
    static let shareInstance : FMDBManager = FMDBManager()
    
    var dbQueue : FMDatabaseQueue?
    
    override init() {
        super.init()
        openDB(dbName: "weather.sqlite")
    }
    

    
    func openDB(dbName:String) {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask , true).first
        let filePath = path?.appending("/" + dbName)
        print(filePath ?? "")
        
        dbQueue = FMDatabaseQueue(path: filePath)
        creatTable()
    }
    
    private func creatTable() {
        let creatTableSQL =  "CREATE TABLE IF NOT EXISTS WEATHER ('city' TEXT NOT NULL PRIMARY KEY ,'weather' TEXT);"
        
        dbQueue?.inDatabase({ (db) in

            if ((try? db.executeUpdate(creatTableSQL, values: nil)) != nil){
                print("创建表成功")
            }
        })
    }
}
