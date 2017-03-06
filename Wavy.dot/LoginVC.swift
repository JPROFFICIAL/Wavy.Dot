//
//  FirstViewController.swift
//  Wavy.dot
//
//  Created by Nina  on 2/28/17.
//  Copyright © 2017 Wavy.dot. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class LoginVC: UIViewController, LoginMethods {

    var model = LoginModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Configuration Methods
    
    func setupLoginButton() {
        
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }
    
    func pushToApp() {
        
        model.setUserDefault()
        self.performSegue(withIdentifier: "goToLinkAccounts", sender: nil)
    }

}

//goToLinkAccounts is segue

// MARK: Facebook Login Delegate
extension LoginVC: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            //Facebook Error Handling
            //https://developers.facebook.com/docs/ios/errors
            
            let errorResponder = ErrorHandler(error: error as NSError, type: .Facebook)
            let errorResponse = errorResponder.respondToError()
            SVProgressHUD.showError(withStatus: errorResponse)
            return
        }
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        model.logUserIn(credential: credential) { [weak self] (err) in
            
            guard let `self` = self else {
                return SVProgressHUD.showError(withStatus: "Internal App Error")
            }
            
            guard err == nil else {
                //Firebase Error Handling
                //https://firebase.google.com/docs/auth/ios/errors
                
                let errorResponder = ErrorHandler(error: error as NSError, type: .Facebook)
                let errorResponse = errorResponder.respondToError()
                SVProgressHUD.showError(withStatus: errorResponse)
                return
            }
            
            self.pushToApp()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
}

// MARK: Login Methods Protocol
protocol LoginMethods {
    var model: LoginModel { get set }
    func setupLoginButton()
    func pushToApp()
}

