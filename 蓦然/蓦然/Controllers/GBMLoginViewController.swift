//
//  GBMLoginViewController.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/11.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import UIKit

class GBMLoginViewController: UIViewController,UITextFieldDelegate,GBMRequestDelegate{
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton:UIButton!
    
    let loginRequest = GBMLoginRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.layer.cornerRadius=5.0
        self.loginButton.clipsToBounds=true

        self.emailTextField.delegate=self
        self.passwordTextField.delegate=self
    }

    @IBAction func loginButtonClicked(sender: AnyObject) {
        
        let email = self.emailTextField.text!
        
        let password = self.passwordTextField.text!
        
        if email.characters.count == 0 || password.characters.count == 0{
            self.showErrorMessage("邮箱和密码不能为空")
        }
        else{
            let params: [String:AnyObject] = Dictionary(dictionaryLiteral: ("email",self.emailTextField.text!),("password",self.passwordTextField.text!),("gbid","GeekBand-I150001"))
            
            self.loginRequest.sendRequest(params, requestDelegate: self)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func touchDownAction(sender: AnyObject) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    //MARK: - GBMRequestDelegate Methods
    
    func requestSuccess(request: GBMRequestBase, data: AnyObject?) {
        
        let user = data as! GBMUserModel
        
        if user.loginReturnMessage == "Login success"{
            
            GBMGlobal.user = user
            GBMGlobal.user!.email = self.emailTextField.text!
            
            let mainStoryboard = UIStoryboard(name: "GBMMain", bundle: NSBundle.mainBundle())
            let mainVC = mainStoryboard.instantiateViewControllerWithIdentifier("MainStoryboard")
            
            self.presentViewController(mainVC, animated: true, completion: nil)
            UIView.animateWithDuration(0.3, animations: {
                self.view.alpha = 0.0
                }, completion: { _ in
                    self.view = nil
            })
        }
        else{
            showErrorMessage(user.loginReturnMessage)
        }
    }

    func requestFailed(request: GBMRequestBase, error: NSError) {
        showErrorMessage(error.description)
    }
    
}
