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

@objc protocol GBMRequestDelegate{
    optional func requestSuccess(request:GBMRequestBase,data:AnyObject?)
    func requestFailed(request:GBMRequestBase,error:NSError)
}

class GBMRequestBase :NSObject, NSURLConnectionDataDelegate{
    
    var urlConnection:NSURLConnection = NSURLConnection()
    
    var receviedData:NSMutableData = NSMutableData()
    
    var delegate:GBMRequestDelegate?
    
    var parser:GBMRequestParserBase?
    
    func sendRequest(params:[String:AnyObject],requestDelegate:GBMRequestDelegate){
    
    }
    
    //MARK: - NSURLConnectionDataDelegate Methods
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.receviedData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        if let parseData = self.parser!.parseJson(self.receviedData){
            delegate?.requestSuccess!(self, data: parseData)
        }
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        delegate?.requestFailed(self, error: error)
    }

}
