//
//  GBMPublishRequest.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/10.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import Foundation

class GBMPublishRequest: GBMRequestBase {
    
    override func sendRequest(params: [String : AnyObject], requestDelegate: GBMRequestDelegate) {
        self.urlConnection.cancel()
        
        self.delegate = delegate
        
        let urlString:NSString = GBMGlobal.moRanApiHost + "picture/create"
        
        let encodeURLString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        let url = NSURL(string: encodeURLString!)
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        
        let form = BLMultipartForm()
        form.addValue(params["token"], forField: "token")
        form.addValue(params["userId"], forField: "user_id")
        form.addValue(params["data"], forField: "data")
        form.addValue(params["title"], forField: "title")
        form.addValue(params["location"], forField: "location")
        form.addValue(params["longitude"], forField: "longitude")
        form.addValue(params["latitude"], forField: "latitude")
        form.addValue(params["location"], forField: "addr")
        
        request.HTTPBody = form.httpBody()
        
        request.setValue(form.contentType(), forHTTPHeaderField: "Content-Type")
        
        self.urlConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
    }
    
    override func connectionDidFinishLoading(connection: NSURLConnection) {
        delegate?.requestSuccess!(self,data: nil)
    }
}
