//
//  LoginFormValidator.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2023/6/19.
//

import Foundation

struct LoginFormConstants {
    
    static let userNameMinlength = 2
    static let userNameMaxlength = 10
    
    static let pwdMinlength = 6
    static let pwdMaxlength = 12
}

class LoginFormValidator {
    
    func isUserNameValid(userName: String) -> Bool{
        if userName.count < LoginFormConstants.userNameMinlength || userName.count > LoginFormConstants.userNameMaxlength {
            return false
        }
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: userName)
    }
    
    
    func isPasswordvalid(password: String) -> Bool {
        
        if password.count < LoginFormConstants.pwdMinlength || password.count > LoginFormConstants.pwdMaxlength {
            return false
        }
        
            // least one uppercase,
            // least one digit
            // least one lowercase
            // least one symbol
            //  min 8 characters total
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
        
    }
    
    
}
