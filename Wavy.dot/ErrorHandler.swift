//
//  ErrorHandler.swift
//  Wavy.dot
//
//  Created by Nina  on 3/6/17.
//  Copyright © 2017 Wavy.dot. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

class ErrorHandler: ErrorHandlerMethods {
    
    var error = NSError()
    var type: ErrorType
    
    // MARK: System Methods
    init(error: NSError, type: ErrorType) {
        self.error = error
        self.type = type
    }
    
    // MARK: Protocol Functions
    func respondToError() -> String {
        
        switch type {
        case .Facebook:
            return respondToFacebookError()
            
        case .Firebase:
            return respondToFirebaseError()
        }
    }
    
    internal func respondToFacebookError() -> String {
        
        guard let _ = FBSDKErrorCode(rawValue: error.code) else {
            return "Bad Facebook Error Code. Try again"
        }
        guard let recoveryDescription = error.userInfo["NSLocalizedRecoverySuggestionErrorKey"] else {
            return "Bad Facebook Login. Try again"
        }
        
        return recoveryDescription as! String
    }
    
    internal func respondToFirebaseError() -> String {
        
        guard let errCode = FIRAuthErrorCode(rawValue: error.code) else {
            return "Internal Error"
        }
        
        switch errCode {
        case .errorCodeNetworkError:
            return "There has been a network error. Please try again"
        case .errorCodeUserNotFound:
            return "There was an error retrieving your user. Please try again"
        case .errorCodeUserTokenExpired:
            return "There was an error authenticating you. Please try logging in again. If this issue persists, redownload the app."
        case .errorCodeTooManyRequests:
            return "There was an internal network error. Please try again momentarily."
        case .errorCodeKeychainError:
            return "There was an error accessing the device keychain. Please try again"
        case .errorCodeInternalError:
            return "There was an internal error. Please try again"
        case .errorCodeInvalidCredential:
            return "Your credentials are invalid. Make sure email and password are correct in device settings"
        case .errorCodeUserDisabled:
            return "Your account has been disabled"
        case .errorCodeOperationNotAllowed:
            return "You are not allowed to login through wavy.dot."
        default:
            return "There was an unnacounted for error. Please contact support@wavydot.com"
        }
    }
}

protocol ErrorHandlerMethods {
    var error: NSError { get set }
    var type: ErrorType { get set }
    func respondToError() -> String
    func respondToFacebookError() -> String
    func respondToFirebaseError() -> String
}

enum ErrorType {
    case Facebook, Firebase
}
