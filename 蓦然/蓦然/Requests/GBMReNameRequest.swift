//
//  GBMReNameRequest.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/20.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import Foundation

class GBMReNameRequest: GBMRequestBase {
    
    override func sendRequest(params: [String : AnyObject], requestDelegate: GBMRequestDelegate) {
        
        self.urlConnection.cancel()
        
        self.delegate = requestDelegate
        
        let urlString:NSString = GBMGlobal.moRanApiHost + "user/rename"
        
        let encodeURLString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        let url = NSURL(string: encodeURLString!)
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = HTTPMethods.Post.rawValue
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        
        let form = BLMultipartForm()
        form.addValue(GBMGlobal.user!.userId, forField: "user_id")
        form.addValue(GBMGlobal.user!.token, forField: "token")
        form.addValue(params["newName"], forField: "new_name")
        
        request.HTTPBody = form.httpBody()
        
        request.setValue(form.contentType(), forHTTPHeaderField: "Content-Type")
        
        self.urlConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        delegate?.requestSuccess(self,data: nil)
    }
}
