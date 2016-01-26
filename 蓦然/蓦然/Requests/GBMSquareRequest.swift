//
//  GBMSquareRequest.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/24.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import Foundation

class GBMSquareRequest: GBMRequestBase {
    
    override init() {
        super.init()
        
        self.parser = GBMSquareRequestParser()
    }
    
    override func sendRequest(params: [String : AnyObject], requestDelegate: GBMRequestDelegate) {
        self.urlConnection.cancel()
        
        self.delegate = requestDelegate
        
        let urlString:NSString = GBMGlobal.moRanApiHost + "node/list?distance=\(params["distance"]!)&latitude=\(params["latitude"]!)&longitude=\(params["longitude"]!)&token=\(params["token"]!)&user_id=\(params["user_id"]!)"
        
        let encodeURLString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        let url = NSURL(string: encodeURLString!)
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        
        self.urlConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
    }
}
