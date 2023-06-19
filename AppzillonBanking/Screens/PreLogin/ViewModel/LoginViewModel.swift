//
//  LoginViewModel.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2022/12/16.
//

import Foundation

class LoginViewModel: NSObject {
    
    private var loginService: LoginServiceProtocol
    
    var authToken = [AuthToken]()
        
    init(loginservice: LoginServiceProtocol = LoginService()) {
        self.loginService = loginservice
    }
    
    
    func fetchAuthToken(completion: @escaping (Bool,_ error:String?) -> ()) {
        loginService.generateAuthToken { success, model, error in
            if success, let authToken = model {
                AuthManager.shared.authToken = authToken.token
                completion(true,nil)
            } else {
                print(error!)
                completion(false,error)
            }
        }
    }
    
        
}


