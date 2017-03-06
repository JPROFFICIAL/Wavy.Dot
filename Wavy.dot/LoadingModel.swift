//
//  LoadingModel.swift
//  Wavy.dot
//
//  Created by Nina  on 3/6/17.
//  Copyright © 2017 Wavy.dot. All rights reserved.
//

import Foundation
import FirebaseAuth

class LoadingModel: LoginModelMethods {
    
    func hasLoginDefault() -> Bool {
        
        guard UserDefaults.standard.value(forKey: "login") != nil else {
            return false
        }
        return true
    }
    
    func createAuthObserver() {
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            
        })
    }
    
}


protocol LoginModelMethods {
    func hasLoginDefault() -> Bool
    func createAuthObserver()
}
