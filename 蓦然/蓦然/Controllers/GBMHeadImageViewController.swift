//
//  GBMHeadImageViewController.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/18.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import UIKit

class GBMHeadImageViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,GBMRequestDelegate {
    
    @IBOutlet weak var headImageView: UIImageView!
    
    var pickerController:UIImagePickerController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        self.headImageView.image = UIImage(named: "defaultHeadImage")
        
    }
    
    //MARK: - View Button Click Method
    
    @IBAction func okButtonClicked(sender: AnyObject) {
        
        var params = [String:AnyObject]()
        params["data"] = UIImageJPEGRepresentation(self.headImageView.image!, 0.00001)
    
        let reImageRequest = GBMReImageRequest()
        reImageRequest.sendRequest(params, requestDelegate: self)

    }
    
    @IBAction func selectImageClicked(sender: AnyObject) {
        let sheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从手机相册中选择")
        
        sheet.showInView((self.tabBarController?.view)!)
    }
    
    //MARK: - Requeat Delegate Method
    
    func requestSuccess(request: GBMRequestBase, data: AnyObject?) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func requestFailed(request: GBMRequestBase, error: NSError) {
        self.showErrorMessage(error.description)
    }

    //MARK: - UIActionSheet Delegate Method
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        self.pickerController = UIImagePickerController()
        
        if buttonIndex == 1 {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                self.pickerController?.sourceType = UIImagePickerControllerSourceType.Camera
                self.pickerController?.allowsEditing = false
                
                self.pickerController?.delegate = self
                self.tabBarController?.presentViewController(self.pickerController!, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertView(title: "错误", message: "无法获取照相机", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                return
            }
        }
        else if buttonIndex == 2 {
            self.pickerController?.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            self.pickerController?.delegate = self
            
            self.tabBarController?.presentViewController(self.pickerController!, animated: true, completion: nil)
        }
    }
    
    //MARK: - UIImagePickerController Delegate Method
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.headImageView.image = image
        
        self.pickerController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
