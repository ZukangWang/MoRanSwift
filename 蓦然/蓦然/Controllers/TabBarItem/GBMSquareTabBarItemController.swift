//
//  GBMSquareTabBarItemController.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/28.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import UIKit

class GBMSquareTabBarItemController: UITabBarItem {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.title = "广场"
        self.image = UIImage(named: "square")?.imageWithRenderingMode(.AlwaysOriginal)
        self.selectedImage = UIImage(named: "square_selected")?.imageWithRenderingMode(.AlwaysOriginal)
        self.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.colorToRGB("#a8a8a9")], forState: .Normal)
        self.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.colorToRGB("#ee7f4l")], forState: .Selected)
    }
}
