//
//  GBMMyViewController.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/15.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import UIKit

class GBMMyViewController: UITableViewController {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //给navigationController设置背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.colorToRGB("#ee7f4l")
        
        let titleLabel = UILabel(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 35))
        titleLabel.text = "我的"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        
        self.navigationItem.titleView = titleLabel
        
        self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2.0
        self.headImageView.clipsToBounds = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.nickNameLabel.text = GBMGlobal.user!.userName
        self.emailLabel.text = GBMGlobal.user!.email
        self.headImageView.image = UIImage(named: "defaultHeadImage")
    }
    
    // MARK: - TableView Data Source Delegate
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        var height:CGFloat = 0;
        
        if section == 0 {
            height = 13.0
        }
        else if section == 1{
            height = 10.0
        }
        
        return height
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //注销登录
        if indexPath.section == 0 && indexPath.row == 2 {
            let alert = UIAlertController(title: nil, message: "确定注销账号吗？", preferredStyle: UIAlertControllerStyle.Alert)
            
            let enterAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler:{
                _ in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                GBMGlobal.user = nil
                
                let loginStoryboard = UIStoryboard(name: "GBMLoginAndRegister", bundle: NSBundle.mainBundle())
                let loginVC = loginStoryboard.instantiateViewControllerWithIdentifier("LoginStoryboard")
                
                self.presentViewController(loginVC, animated: true, completion: nil)
                UIView.animateWithDuration(0.3, animations: {
                        self.view.alpha = 0.0
                    }, completion: { _ in
                        self.view = nil
                })
            })
            
            alert.addAction(enterAction)
            
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
