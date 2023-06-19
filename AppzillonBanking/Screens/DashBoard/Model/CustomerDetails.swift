//
//  CustomerDetails.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2022/12/16.
//

import Foundation

// MARK: - UserDetails
struct UserDetails: Codable {
    let apiResponse: APIResponse
}

// MARK: - APIResponse
struct APIResponse: Codable {
    let responseHeader: ResponseHeader
    let responseBody: ResponseBody
    enum CodingKeys: String, CodingKey {
        case responseHeader = "ResponseHeader"
        case responseBody = "ResponseBody"
    }
}

// MARK: - ResponseBody
struct ResponseBody: Codable {
    var responseObj: String
}

// MARK: - ResponseHeader
struct ResponseHeader: Codable {
    let responseCode, responseMessage: String
    enum CodingKeys: String, CodingKey {
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
    }
}

//struct ResponseObj: Codable {
//    let serviceStatusCode:  String
//    let customerDetails:CustomerDetails
//    let accountDetails:[AccountDetails]
//}
//
//struct CustomerDetails: Codable{
//    let customerId: String
//    let customerName: String
//    let customerType: String
//    let dob: String
//    let mobileNum: String
//    let emailId: String
//    let permAddress: String
//    let communicationAddress: String
//}
//
//struct AccountDetails: Codable {
//    let customerId: String
//    let customerName: String
//    let accountNo: String
//    let accountType: String
//    let accountDetails: String
//    let currency: String
//    let availableBalance: String
//    let availBalanceFcy: String
//    let nickName: String
//    let creditAllowed: String
//    let debitAllowed: String
//    let acctName: String
//    let showHideAccounts: String
//}
