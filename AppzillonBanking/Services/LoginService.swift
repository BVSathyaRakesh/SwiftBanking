//
//  LoginServices.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2022/12/15.
//

import Foundation

protocol LoginServiceProtocol {
    
    func generateAuthToken(completion: @escaping (_ success: Bool, _ results: AuthToken?, _ error: String?) -> ())
    
}

class LoginService: LoginServiceProtocol {
    
    func generateAuthToken(completion: @escaping (Bool, AuthToken?, String?) -> ()) {
        HttpRequestHelper().POST(url: "/generateToken", params: ["username": "user","password":"user"], httpHeader: .application_json) { successStatus, data in
            if successStatus {
                do {
                    let model = try JSONDecoder().decode(AuthToken.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Employees to model")
                }
            } else {
                completion(false, nil, "Error: Employees GET Request failed")
            }
        }
    }
    
    
}
