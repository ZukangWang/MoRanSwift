//
//  GBMNickNameViewController.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/18.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import UIKit

class GBMNickNameViewController: UIViewController,GBMRequestDelegate{

    @IBOutlet weak var newNickName: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }
    
    @IBAction func okButtonClicked(sender: AnyObject) {
        let renameRequest = GBMReNameRequest()
        var params = [String:AnyObject]()
        params["newName"] = self.newNickName.text!
        renameRequest.sendRequest(params, requestDelegate: self)
    }
    
    //MARK: - GBMRequestDelegate Methods
    
    func requestSuccess(request: GBMRequestBase, data: Any?) {
        GBMGlobal.user!.userName = self.newNickName.text!
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func requestFailed(request: GBMRequestBase, error: NSError) {
        self.showErrorMessage(error.description)
    }
}
