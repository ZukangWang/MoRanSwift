//
//  GBMLocationRequestParser.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/23.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import Foundation

class GBMLocationRequestParser: GBMRequestParserBase {

    override func parseJson(data: NSData) -> AnyObject? {
        do{
            let jsonDic: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            var dataArray = [GBMLocationModel]()
            
            let poisData = jsonDic.valueForKey("pois") as! NSArray
            for item in poisData {
                let itemData = item as! NSDictionary
                
                let locationModel = GBMLocationModel()
                locationModel.name = itemData.valueForKey("name") as! String
                locationModel.address = itemData.valueForKey("address") as! String
                
                dataArray.append(locationModel)

            }
            
            return dataArray
        }
        catch{
            
        }
        
        return nil
    }
}
