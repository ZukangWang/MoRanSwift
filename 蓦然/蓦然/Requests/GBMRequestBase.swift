//
//  GBMRequestBase.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/23.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import Foundation

enum HTTPMethods:String{
    case Get = "GET"
    case Post = "POST"
    case Put = "PUT"
    case Delete = "DELETE"
}

protocol GBMRequestDelegate{
    func requestSuccess(request:GBMRequestBase,data:Any?)
    func requestFailed(request:GBMRequestBase,error:NSError)
}

class GBMRequestBase :NSObject, NSURLConnectionDataDelegate{
    
    var urlConnection:NSURLConnection = NSURLConnection()
    
    var receviedData:NSMutableData = NSMutableData()
    
    var delegate:GBMRequestDelegate?
        
    func sendRequest(params:[String:AnyObject],requestDelegate:GBMRequestDelegate){
    
    }
    
    //MARK: - NSURLConnectionDataDelegate Methods
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.receviedData.appendData(data)
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        delegate?.requestFailed(self, error: error)
    }

}
