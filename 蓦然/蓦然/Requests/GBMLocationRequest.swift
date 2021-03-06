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

    override func sendRequest(params: [String : AnyObject], requestDelegate: GBMRequestDelegate) {
        
        self.urlConnection.cancel()
        
        self.delegate = requestDelegate
        
        let urlString:NSString = "http://restapi.amap.com/v3/place/around?key=446e0fdcfcdca37c29b40edf3530ae9b&location=\(params["currentLongitude"]),\(params["currentLatitude"])&offset=10"
        
        let encodeURLString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        let url = NSURL(string: encodeURLString!)
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = HTTPMethods.Get.rawValue
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        
        self.urlConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        let jsonDic = try! NSJSONSerialization.JSONObjectWithData(self.receviedData, options: NSJSONReadingOptions.AllowFragments) as! [String:AnyObject]
        
        var dataArray = [GBMLocationModel]()
        
        let poisData = jsonDic["pois"] as! Array<AnyObject>
        for item in poisData {
            let itemData = item as! [String:AnyObject]
            
            let locationModel = GBMLocationModel(attributes: itemData)
            
            dataArray.append(locationModel)
            
        }
    }
}
