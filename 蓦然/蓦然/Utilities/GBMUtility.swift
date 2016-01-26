//
//  GBMUtility.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/13.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import Foundation

class GBMUtility: NSObject {

    //邮箱验证
    static func validateEmail(email:NSString)->Bool{
        
        if email == "" {
            return false
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [emailRegex])
        
        return emailPredicate.evaluateWithObject(email)
    }
    
    //密码验证，密码为6-20位的字母或数字
    static func validatePassword(password:NSString)->Bool{
        
        if password == ""{
            return false
        }
        
        let passwordRegex = "^[a-zA-Z0-9]{6,20}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [passwordRegex])
        
        return passwordPredicate.evaluateWithObject(password)
    }
}
