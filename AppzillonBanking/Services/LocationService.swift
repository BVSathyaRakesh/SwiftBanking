//
//  LocationService.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2023/1/2.
//

import Foundation


protocol LocationServiceProtocol {
    
    func getBankLocatorDetails(parameters:[String: Any], completion: @escaping (_ success: Bool, _ results: LocationDetails?, _ error: String?) -> ())
    
}


class LocationService: LocationServiceProtocol  {
    
    func getBankLocatorDetails(parameters:[String: Any] ,completion: @escaping (Bool, LocationDetails?, String?) -> ()) {
        HttpRequestHelper().POST(url: "/bank/location", params: parameters, httpHeader: .application_json) { successStatus, data in
            if successStatus {
                do {
                    let model = try JSONDecoder().decode(LocationDetails.self, from: data!)
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
