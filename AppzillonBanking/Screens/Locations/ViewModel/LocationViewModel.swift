//
//  LocationViewModel.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2023/1/2.
//

import Foundation



class LocationViewModel {

    var userDetails = [LocationDetails]()

    private var locationService: LocationServiceProtocol

    init(locationService: LocationServiceProtocol = LocationService()) {
        self.locationService = locationService
    }
    
    
    func getLocators(lat: String,longi:String, completion: @escaping ([LocatorsData]?,Bool) -> ()){
        
        let paramsDictonary : [String: Any] = [ "apiRequest": ["appId":"APZRMB","userId":"000000000001","interfaceName":"BranchLocationDetails","requestObj": [ "lattitude": lat,"longitude": longi ]]]
        
        locationService.getBankLocatorDetails(parameters: paramsDictonary) { success, results, error in
            if success, let userDetails = results  {
                let data = Data(userDetails.apiResponse.responseBody.responseObj.utf8)
                do {
                    let model = try JSONDecoder().decode([LocatorsData].self, from: data)
                  //  print(model)
                    completion(model,true)
                } catch {
                    completion([],true)
                }
                completion([],true)
            }else {
                completion([],false)
                print("error is \(String(describing: error))")
            }
        }

    }
    
        @objc func getDictionaryObject(content: Any) -> [AnyHashable: Any] {
            var jsonDictionary: [AnyHashable: Any] = [:]
            if let content = content as? [AnyHashable: Any] {
                jsonDictionary = content
            }
            if let content = content as? String {
                let stringContentData = Data(content.utf8)
                if let jsonDictionary = try? JSONSerialization.jsonObject(with: stringContentData, options: []) as? [AnyHashable: Any] {
                    return jsonDictionary
                }
            }
            return jsonDictionary
        }
    
}
