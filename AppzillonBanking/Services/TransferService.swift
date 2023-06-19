//
//  TransferService.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2022/12/28.
//

import Foundation


protocol TransferServiceProtocol {
    
    func getBeneficiaryDetails(completion: @escaping (Bool, Beneficiaries?, String?) -> ())
}


class TransferService: TransferServiceProtocol  {

    
    
    func getBeneficiaryDetails(completion: @escaping (Bool, Beneficiaries?, String?) -> ()) {
        
        let paramsDictonary : [String: Any] = [ "apiRequest": ["appId":"APZRMB","userId":"000000000001","interfaceName":"BenificiaryList","requestObj": [ "customerId": "000000000001", "beneficiaryType": "OTH", ]]]
        
        HttpRequestHelper().POST(url: "/beneficiary/list", params: paramsDictonary, httpHeader: .application_json) { successStatus, data in
            if successStatus {
                do {
                    let model = try JSONDecoder().decode(Beneficiaries.self, from: data!)
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
