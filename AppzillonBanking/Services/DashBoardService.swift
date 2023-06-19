//
//  DashBoardService.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2022/12/16.
//

import Foundation

protocol DashBoardServiceProtocol {
    
    func getUserDetails(completion: @escaping (_ success: Bool, _ results: UserDetails?, _ error: String?) -> ())
}


class DashBoardService: DashBoardServiceProtocol  {
    
    func getUserDetails(completion: @escaping (Bool, UserDetails?, String?) -> ()) {
        
        let paramsDictonary : [String: Any] = [ "apiRequest": ["appId":"APZRMB","userId":"000000000001","interfaceName":"Customer360","requestObj": [ "customerId": "000000000001" ]]]
        
        HttpRequestHelper().POST(url: "/user/customer360details", params: paramsDictonary, httpHeader: .application_json) { successStatus, data in
            if successStatus {
                do {
                    let model = try JSONDecoder().decode(UserDetails.self, from: data!)
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
