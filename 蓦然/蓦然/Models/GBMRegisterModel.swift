//
//  GBMRegisterModel.swift
//  蓦然
//
//  Created by 王祖康 on 16/2/3.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import Foundation

struct GBMRegisterModel {
    
    //用户注册返回信息
    var registerReturnMessage = ""
    
    init?(attributes:[String:AnyObject]){
        if let registerReturnMessage = attributes["message"] as? String {
            self.registerReturnMessage = registerReturnMessage
        }
    }
}