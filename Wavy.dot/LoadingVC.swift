//
//  LoadingVC.swift
//  Wavy.dot
//
//  Created by Nina  on 3/6/17.
//  Copyright © 2017 Wavy.dot. All rights reserved.
//

import Foundation
import FirebaseAuth

class LoadingVC: UIViewController, LoadingMethods {
    
    var model = LoadingModel()
    
    // MARK: System Methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureLogin()
    }
    
    // MARK: Configuration Methods
    
    func configureLogin() {
        
        guard model.hasLoginDefault() == true else {
            performSegue(withIdentifier: "goToLogin", sender: nil)
            return
        }
        
        performSegue(withIdentifier: "goToApp", sender: nil)
    }
    
}

// MARK: LoadingMethods Protocol

protocol LoadingMethods {
    var model: LoadingModel { get set }
    func configureLogin()
}
