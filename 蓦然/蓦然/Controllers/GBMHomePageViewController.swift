//
//  GBMHomePageViewController.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/20.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import UIKit

class GBMHomePageViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "http://geekband.com"
        let url = NSURL(string: urlString)
        
        self.webView.loadRequest(NSURLRequest(URL: url!))
        
    }
}
