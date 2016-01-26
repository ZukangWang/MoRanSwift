//
//  GBMRegisterRequest.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/13.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import Foundation

class GBMRegisterRequest: GBMRequestBase {
    
    override init() {
        super.init()
        
        self.parser = GBMRegisterRequestParser()
    }
    
    override func sendRequest(params: [String : AnyObject], requestDelegate: GBMRequestDelegate) {
        self.urlConnection.cancel()
        
        self.delegate = requestDelegate
        
        let urlString:NSString = GBMGlobal.moRanApiHost + "user/register"
        
        let encodeURLString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        let url = NSURL(string: encodeURLString!)
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        
        let form = BLMultipartForm()
        form.addValue(params["username"], forField: "username")
        form.addValue(params["email"], forField: "email")
        form.addValue(params["password"], forField: "password")
        form.addValue(params["gbid"], forField: "gbid")
        
        request.HTTPBody = form.httpBody()
        
        request.setValue(form.contentType(), forHTTPHeaderField: "Content-Type")
        
        self.urlConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
    }
}
