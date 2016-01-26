//
//  GBMRegisterController.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/12.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import UIKit

class GBMRegisterController: UIViewController,UITextFieldDelegate,GBMRequestDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let registerRequest = GBMRegisterRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.registerButton.layer.cornerRadius=5.0
        self.registerButton.clipsToBounds=true
        
        self.emailTextField.delegate = self
        self.nickTextField.delegate = self
        self.passwordTextField.delegate = self
        self.repeatPasswordTextField.delegate = self
    }
    
    @IBAction func touchDownAction(sender: AnyObject) {
        self.emailTextField.resignFirstResponder()
        self.nickTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.repeatPasswordTextField.resignFirstResponder()
        
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    @IBAction func loginButtonClicked(sender: AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func registerButtonClicked(sender: AnyObject){
        let nick = self.nickTextField.text!
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        let repeatPassword = self.repeatPasswordTextField.text!
        
        if nick.characters.count == 0
            || email.characters.count == 0
            || password.characters.count == 0
            || repeatPassword.characters.count == 0{
            showErrorMessage("邮箱、昵称、密码不能为空")
        }
        else if(GBMUtility.validateEmail(email)==false) {
            showErrorMessage("输入邮箱格式不正确")
        }
        else if(GBMUtility.validatePassword(password)==false){
            showErrorMessage("输入密码格式不正确，请输入6-20位的字母或数字")
        }
        else if(password != repeatPassword){
            showErrorMessage("两次输入的密码不一致")
        }
        else{
            var params = [String:AnyObject]()
            params["username"] = self.nickTextField.text!
            params["email"] = self.emailTextField.text!
            params["password"] = self.passwordTextField.text!
            params["gbid"] = "GeekBand-I150001"
            
            self.registerRequest.sendRequest(params, requestDelegate: self)
        }
    }
    
    //MARK: - UITextFieldDelegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let frame = self.registerButton.frame
        let offset = frame.origin.y + 36 - (view.frame.size.height-216)
        
        let animationDuration:NSTimeInterval = 0.30
        UIView.beginAnimations("ResizeForKeyboard", context: nil)
        UIView.setAnimationDuration(animationDuration)
        
        if offset > 0 {
            view.frame = CGRect(x: 0, y: -offset, width: view.frame.size.width, height: view.frame.size.height)
            
            UIView.commitAnimations()
        }
    }
    
    //MARK: - GBMRequestDelegate Methods
    
    func requestSuccess(request: GBMRequestBase, data: AnyObject?) {
        
        let registerReturnMessage = data as! String
        
        if registerReturnMessage == "Register success" {
            let alert = UIAlertView(title: nil, message: "注册成功，请登陆", delegate: nil, cancelButtonTitle: "确定")
            
            alert.show()
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    func requestFailed(request: GBMRequestBase, error: NSError) {
        showErrorMessage(error.description)
    }

}
