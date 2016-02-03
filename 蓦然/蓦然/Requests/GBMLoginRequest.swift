//
//  GBMLoginRequest.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/11.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import Foundation

class GBMLoginRequest: GBMRequestBase {
    
    override func sendRequest(params: [String : AnyObject], requestDelegate: GBMRequestDelegate) {
        
        self.urlConnection.cancel()
        
        self.delegate = requestDelegate
        
        let urlString:NSString = GBMGlobal.moRanApiHost+"user/login"
        
        let encodeURLString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        let url = NSURL(string: encodeURLString!)
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = HTTPMethods.Post.rawValue
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        
        let form = BLMultipartForm()
        form.addValue(params["email"], forField: "email")
        form.addValue(params["password"], forField: "password")
        form.addValue(params["gbid"], forField: "gbid")

        request.HTTPBody = form.httpBody()
        
        request.setValue(form.contentType(), forHTTPHeaderField: "Content-Type")
        
        self.urlConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        
        let attributes = try! NSJSONSerialization.JSONObjectWithData(self.receviedData, options: NSJSONReadingOptions.AllowFragments) as! [String:AnyObject]
        
        if let parserData = GBMUserModel(attributes: attributes) {
            delegate?.requestSuccess(self, data: parserData)
        }
    }
}
