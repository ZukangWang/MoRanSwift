//
//  GBMLoginRequestParser.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/11.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import Foundation

class GBMLoginRequestParser: GBMRequestParserBase {
    
    override func parseJson(data: NSData) -> AnyObject? {
        do{
            let jsonDic: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            let returnMessage = jsonDic.valueForKey("message") as! String
            
            let user = GBMUserModel()
            user.loginReturnMessage = returnMessage
            
            let data = jsonDic.valueForKey("data") as! NSDictionary
            user.userId = data.valueForKey("user_id") as! String
            user.token = data.valueForKey("token") as! String
            user.userName = data.valueForKey("user_name") as! String
            
            return user
        }
        catch{
            
        }
        
        return nil
    }
}
