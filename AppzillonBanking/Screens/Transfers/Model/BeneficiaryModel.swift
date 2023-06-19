//
//  BeneficiaryModel.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2023/1/4.
//

import Foundation

// MARK: - Beneficiaries
struct Beneficiaries: Codable {
    let apiResponse: BeneficiaryAPIResponse
}

// MARK: - APIResponse
struct BeneficiaryAPIResponse: Codable {
    let responseHeader: BeneficiaryResponseHeader
    let responseBody: BeneficiaryResponseBody

    enum CodingKeys: String, CodingKey {
        case responseHeader = "ResponseHeader"
        case responseBody = "ResponseBody"
    }
}

// MARK: - ResponseBody
struct BeneficiaryResponseBody: Codable {
    let responseObj: String
}

// MARK: - ResponseHeader
struct BeneficiaryResponseHeader: Codable {
    let responseCode, responseMessage: String

    enum CodingKeys: String, CodingKey {
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
    }
}


// MARK: - ResponseString
struct BeneficiariesData : Decodable {
    
    let beneficiaryAccountNo: String
    let beneficiaryIfsc: String
    let beneficiaryEmail: String
    let beneficiaryAccountType: String
    let beneficiaryBankName: String
    let beneficiaryName: String
    let customerId: String
    let beneficiaryBankAddress: String
    let beneficiaryId: String
    let beneficiaryType: String
    let beneficiaryShortName: String
    let currency: String
    
}
