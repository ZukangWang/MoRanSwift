//
//  GBMPublishRequestParser.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/10.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import Foundation

class GBMPublishRequestParser: GBMRequestParserBase {
    
    override func parseJson(data: NSData) -> AnyObject? {
        do{
            let jsonDic: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            let returnData = jsonDic.valueForKey("data") as! NSDictionary
            
            return returnData.valueForKey("pic_id") as? NSString
        }
        catch{
            
        }
        
        return nil
    }
}
