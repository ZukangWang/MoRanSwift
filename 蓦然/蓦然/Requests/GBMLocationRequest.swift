//
//  GBMLocationRequest.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/17.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import Foundation

protocol GBMLocationRequestDelegate:GBMRequestDelegate{
    func locationRequestSuccess(request: GBMLocationRequest, data: Array<GBMLocationModel>)
}

class GBMLocationRequest: GBMRequestBase {

    override init() {
        super.init()
        
        self.parser = GBMLocationRequestParser()
    }

    override func sendRequest(params: [String : AnyObject], requestDelegate: GBMRequestDelegate) {
        
        self.urlConnection.cancel()
        
        self.delegate = requestDelegate
        
        let urlString:NSString = "http://restapi.amap.com/v3/place/around?key=446e0fdcfcdca37c29b40edf3530ae9b&location=\(params["currentLongitude"]),\(params["currentLatitude"])&offset=10"
        
        let encodeURLString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        let url = NSURL(string: encodeURLString!)
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        
        self.urlConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
    }
}
