//
//  UIViewController.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/24.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import UIKit

extension UIViewController{
    
    //MARK: - AlertMessage Methods
    
    func showErrorMessage(message:String){
        let alert = UIAlertView(title: nil, message: message, delegate: nil, cancelButtonTitle: "确定")
        
        alert.show()
    }
}
