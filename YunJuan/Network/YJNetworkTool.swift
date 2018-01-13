//
//  YJNetworkTool.swift
//  YunJuan
//
//  Created by 汤泽川 on 2018/1/13.
//  Copyright © 2018年 tzcccy. All rights reserved.
//

import UIKit

enum HTResqustMethod : String {
    
    case Post = "post"
    case Get = "get"
}

public class YJNetworkTool: AFHTTPSessionManager {
    static let shareManager: YJNetworkTool = {
        let tools = YJNetworkTool()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
    
    func request(method: HTResqustMethod , urlString: String, parameters: AnyObject?,success : @escaping([String : Any]) -> (), failure : @escaping(Error?) -> ()){
        
        // 定义一个请求成功之后要执行的闭包
        // 成功闭包
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
            if(responseObj != nil){
                success(responseObj as! [String : Any])
            }else{
                //失败处理
                failure(nil)
            }
            
        }
        
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
        
        // Get 请求
        if method == .Get {
            get(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        // Post 请求
        if method == .Post {
            post(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        
    }
    
}
