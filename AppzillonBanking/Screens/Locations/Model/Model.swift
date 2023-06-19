//
//  Model.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2023/1/2.
//

import Foundation


// MARK: - LocationDetails
struct LocationDetails: Codable {
    let apiResponse: LocationAPIResponse
}

// MARK: - APIResponse
struct LocationAPIResponse: Codable {
    let responseHeader: LocationResponseHeader
    let responseBody: LocationResponseBody

    enum CodingKeys: String, CodingKey {
        case responseHeader = "ResponseHeader"
        case responseBody = "ResponseBody"
    }
}

// MARK: - ResponseBody
struct LocationResponseBody: Codable {
    let responseObj: String
}

// MARK: - ResponseHeader
struct LocationResponseHeader: Codable {
    let responseCode, responseMessage: String

    enum CodingKeys: String, CodingKey {
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
    }
}



struct LocatorsData : Decodable {
    
    let location: String
    let city: String
    let state: String
    let address: String
    let latitude: String
    let longitude: String
    let phone: String
    let bankType: String

}
