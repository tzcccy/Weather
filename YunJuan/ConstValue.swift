//
//  ConstValue.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/14.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import Foundation

/// 天气数据过时小时数
let MaxUpdateHour = 3

let ErrorMsg = "无法访问"
let NetWorkError = "网络错误"


func YJLog<T>(_ message : T, filename : String = #file, methodName: String = #function, lineNumber: Int = #line){
    #if DEBUG
        let logStr : String = (filename as NSString).pathComponents.last!.replacingOccurrences(of: "swift", with: "")
        print("类：\(logStr) 方法：\(methodName) 行：[\(lineNumber)] 数据：\(message)")
    #endif
}
