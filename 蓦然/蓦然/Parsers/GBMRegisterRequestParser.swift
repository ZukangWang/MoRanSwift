//
//  GBMRegisterRequestParser.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/13.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import Foundation

class GBMRegisterRequestParser: GBMRequestParserBase {
    
    override func parseJson(data: NSData) -> AnyObject? {
        do{
            let jsonDic: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            let returnMessage = jsonDic.valueForKey("message") as! String
            
            return returnMessage
        }
        catch{
            
        }
        
        return nil
    }
}
