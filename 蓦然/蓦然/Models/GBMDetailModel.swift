//
//  GBMViewDetailModel.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/8.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import Foundation

struct GBMDetailModel {
    //评论
    var comment = ""
    //编辑日期
    var modified = ""
    
    init(attributes:[String:AnyObject]){
        
        if let comment = attributes["comment"] as? String {
            self.comment = comment
        }
        
        if let modified = attributes["modified"] as? String {
            self.modified = modified
        }
    }
}
