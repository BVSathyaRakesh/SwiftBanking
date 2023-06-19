//
//  AuthTokenModel.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2022/12/16.
//

import Foundation

struct AuthToken : Decodable{
    let token, expiryDate: String
}
