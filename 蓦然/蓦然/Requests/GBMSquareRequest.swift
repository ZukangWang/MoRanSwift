//
//  GBMSquareRequest.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/24.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import Foundation

class GBMSquareRequest: GBMRequestBase {
    
    override func sendRequest(params: [String : AnyObject], requestDelegate: GBMRequestDelegate) {
        self.urlConnection.cancel()
        
        self.delegate = requestDelegate
        
        let urlString:NSString = GBMGlobal.moRanApiHost + "node/list?distance=\(params["distance"]!)&latitude=\(params["latitude"]!)&longitude=\(params["longitude"]!)&token=\(params["token"]!)&user_id=\(params["user_id"]!)"
        
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
        
        var parseData = [String:Array<GBMPictureModel>]()
        
        for dic in (jsonDic["data"]?.allValues)!{
            
            var pictureArray = [GBMPictureModel]()
            
            for picDictionary in (dic["pic"] as! Array<AnyObject>){
                
                let pictureModel = GBMPictureModel(attributes: picDictionary as! [String:AnyObject])
                
                pictureArray.append(pictureModel)
            }
            
            let address = (dic["node"] as! [String:AnyObject])["addr"] as! String
            
            parseData[address] = pictureArray
            
        }
        
        delegate?.requestSuccess(self, data: parseData)
    }
}
