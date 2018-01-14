//
//  YJGlobalTools.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/14.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import UIKit

func getDefaultCity() -> String?{
    return UserDefaults.standard.string(forKey: "DefaultCity")
}

func setDefaultCity(city : String) {
    UserDefaults.standard.set(city, forKey: "DefaultCity")
}
