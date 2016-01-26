//
//  GBMMainViewController.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/16.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import UIKit

class GBMMainViewController: UITabBarController,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var pickerController:UIImagePickerController? = nil

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoButton = UIButton(frame:CGRectMake(view.frame.width/2-60,-25,120,50))
        photoButton.setImage(UIImage(named: "publish"), forState: UIControlState.Normal)
        photoButton.addTarget(self, action: "photoButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.tabBar.addSubview(photoButton)
        
        //去除TabBar黑线，并设置背景颜色
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.backgroundColor = UIColor(red: 235/255.0, green: 236/255.0, blue: 236/255.0, alpha: 1.0)
    }
    
    //MARK: - Publish Button Clicked Mehthods
    
    @objc private func photoButtonClicked(){
        
        let sheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从手机相册中选择")
        
        sheet.showInView(self.view)
    }

    //MARK: - UIActionSheet Delegate Methods
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        self.pickerController = UIImagePickerController()
        
        if buttonIndex == 1 {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                self.pickerController?.sourceType = UIImagePickerControllerSourceType.Camera
                self.pickerController?.allowsEditing = false
                
                self.pickerController?.delegate = self
                self.presentViewController(self.pickerController!, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertView(title: "错误", message: "无法获取照相机", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                return
            }
        }
        else if buttonIndex == 2 {
            self.pickerController?.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.pickerController?.delegate = self
            
            self.presentViewController(self.pickerController!, animated: true, completion: nil)
        }
    }
    
    //MARK: - UIImagePickerController Delegate Method
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        image = UIImage(CGImage: image.CGImage!, scale:(413/626), orientation:image.imageOrientation)
        
        if self.pickerController?.sourceType == UIImagePickerControllerSourceType.PhotoLibrary {
            let publishStoryboard = UIStoryboard(name: "GBMPublish", bundle: NSBundle.mainBundle())
            let publishVC = publishStoryboard.instantiateViewControllerWithIdentifier("PublishStoryboard") as!GBMPublishViewController
            publishVC.tag = 2
            publishVC.publishPhoto = image
            
            picker.pushViewController(publishVC, animated: true)
        }
        else{
            let publishStoryboard = UIStoryboard(name: "GBMPublish", bundle: NSBundle.mainBundle())
            let publishVC = publishStoryboard.instantiateViewControllerWithIdentifier("PublishStoryboard") as!GBMPublishViewController
            
            publishVC.tag = 1
            publishVC.publishPhoto = image
            
            let publishNC = UINavigationController(rootViewController: publishVC)
            
            picker.presentViewController(publishNC, animated: true, completion: nil)
        }
        
    }
}
