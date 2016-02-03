//
//  GBMPictureModel.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/24.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import Foundation

struct GBMPictureModel {
    
    //图片Link
    var pictureLink = ""
    
    //图片ID
    var picureId = ""
    
    //标题
    var title = ""
    
    init(attributes:[String:AnyObject]){
        
        if let pictureLink = attributes["pic_link"] as? String {
            self.pictureLink = pictureLink
        }
        
        if let picureId = attributes["pic_id"] as? String {
            self.picureId = picureId
        }
        
        if let title = attributes["title"] as? String {
            self.title = title
        }
        
    }
}
