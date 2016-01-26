//
//  GBMSquareRequestParser.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/24.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import Foundation

class GBMSquareRequestParser: GBMRequestParserBase {
    
    override func parseJson(data: NSData) -> AnyObject? {
        do{
            let jsonDic: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            var parseData = [String:Array<GBMPictureModel>]()
            
            for dic in (jsonDic.valueForKey("data")?.allValues)!{
                
                var pictureArray = [GBMPictureModel]()
                
                for picDictionary in (dic["pic"] as! NSArray){
                    
                    let pictureModel = GBMPictureModel()
                    
                    pictureModel.pictureLink = picDictionary["pic_link"] as! String
                    pictureModel.picureId = picDictionary["pic_id"] as! String
                    pictureModel.title = picDictionary["title"] as! String
                    
                    pictureArray.append(pictureModel)
                }
                
                let address = (dic["node"] as! NSDictionary)["addr"] as! String
                
                parseData[address] = pictureArray
                
            }
            
            return parseData
        }
        catch{
            
        }
        
        return nil
    }
}
