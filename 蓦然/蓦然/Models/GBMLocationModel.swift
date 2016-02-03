//
//  GBMLocationModel.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/23.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import Foundation

struct GBMLocationModel {
    
    var name = ""
    
    var address = ""
    
    init(attributes:[String:AnyObject]){
        
        if let name = attributes["name"] as? String {
            self.name = name
        }
        
        if let address = attributes["address"] as? String {
            self.address = address
        }
        
    }
}
