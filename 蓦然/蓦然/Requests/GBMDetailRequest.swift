//
//  GBMViewDetailRequest.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/3.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import Foundation

class GBMDetailRequest: GBMRequestBase {

    override init() {
        super.init()
        
        self.parser = GBMDetailRequestParser()
    }
    
    override func sendRequest(params: [String : AnyObject], requestDelegate: GBMRequestDelegate) {
        self.urlConnection.cancel()
        
        self.delegate = requestDelegate
        
        let urlString:NSString = GBMGlobal.moRanApiHost + "comment?user_id=\(params["user_id"]!)&token=\(params["token"]!)&pic_id=\(params["pic_id"]!)"
        
        let encodeURLString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        let url = NSURL(string: encodeURLString!)
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = HTTPMethods.Get.rawValue
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        
        self.urlConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
    }
}
