//
//  LoginModel.swift
//  Wavy.dot
//
//  Created by Nina  on 3/1/17.
//  Copyright © 2017 Wavy.dot. All rights reserved.
//

import Foundation
import FirebaseAuth

class LoginModel: LoginModelMethods {
    
    // MARK: Login Functions
    func logUserIn(credential: FIRAuthCredential, done:@escaping(_ error: Error?) -> Void) {
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, err) in
            
            return done(err)
        })
    }
    
    func setUserDefault() {
        UserDefaults.standard.setValue(true, forKey: "login")
    }
}

// MARK: Login Model Protocol

protocol LoginModelMethods {
    func logUserIn(credential: FIRAuthCredential, done:@escaping(_ error: Error?) -> Void)
    func setUserDefault()
}
