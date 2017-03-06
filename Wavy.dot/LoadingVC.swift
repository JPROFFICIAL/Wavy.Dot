//
//  LoadingVC.swift
//  Wavy.dot
//
//  Created by Nina  on 3/6/17.
//  Copyright © 2017 Wavy.dot. All rights reserved.
//

import Foundation
import FirebaseAuth

class LoadingVC: UIViewController {
    
    let model = LoadingModel()
    
    // MARK: System Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLogin()
    }
    
    // MARK: Configuration Methods
    
    fileprivate func configureLogin() {
        
        guard model.hasLoginDefault() == true else {
            performSegue(withIdentifier: "goToLogin", sender: nil)
            return
        }
        
        performSegue(withIdentifier: "goToApp", sender: nil)
    }
    
}
