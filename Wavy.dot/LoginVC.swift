//
//  FirstViewController.swift
//  Wavy.dot
//
//  Created by Nina  on 2/28/17.
//  Copyright © 2017 Wavy.dot. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    let model = LoginModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Configuration Methods
    
    fileprivate func setupLoginButton() {
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }

}

// MARK: Facebook Login Delegate
extension LoginVC: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            //Facebook Error Handling
            //https://developers.facebook.com/docs/ios/errors
            return
        }
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        model.logUserIn(credential: credential) { (err) in
            
            guard err == nil else {
                //Firebase Error Handling
                //https://firebase.google.com/docs/auth/ios/errors
                return
            }
            
            //Push to link accounts screen
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
}

