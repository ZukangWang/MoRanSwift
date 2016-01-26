//
//  GBMViewDetailParser.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/6.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import Foundation

class GBMDetailRequestParser: GBMRequestParserBase {
    
    override func parseJson(data: NSData) -> AnyObject? {
        do{
            let jsonDic: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            var dataArray = [GBMDetailModel]()
            
            let viewDetailData = jsonDic.valueForKey("data") as! NSArray
            
            for item in viewDetailData {
                let itemData = item as! NSDictionary
                
                let viewDetailModel = GBMDetailModel()
                viewDetailModel.comment = itemData.valueForKey("comment") as! String
                viewDetailModel.modified = itemData.valueForKey("modified") as! String
                
                dataArray.append(viewDetailModel)
            }
            
            return dataArray
        }
        catch{
            
        }
        
        return nil

    }
}
