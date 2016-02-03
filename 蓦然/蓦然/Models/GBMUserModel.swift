//
//  GBMUserModel.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/11.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import Foundation

struct GBMUserModel {
    //用户名
    var userName = ""
    
    //邮箱
    var email = ""
    
    //密码
    var password = ""
    
    //Token
    var token = ""
    
    //用户ID
    var userId = ""
    
    //登录接口返回的信息
    var loginReturnMessage = ""
    
    init(){
    
    }
    
    init?(attributes:[String:AnyObject]){
        
        if let loginReturnMessage = attributes["message"] as? String {
            self.loginReturnMessage = loginReturnMessage
        }
        
        if let userData = attributes["data"] as? [String:AnyObject] {
            
            if let userName = userData["user_name"] as? String {
                self.userName = userName
            }
            
            if let userId = userData["user_id"] as? String {
                self.userId = userId
            }
            
            if let token = userData["token"] as? String {
                self.token = token
            }
            
        }
    }
}
