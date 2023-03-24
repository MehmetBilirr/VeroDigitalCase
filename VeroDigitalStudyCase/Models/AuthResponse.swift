//
//  AuthResponse.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 24.03.2023.
//

import Foundation

struct AuthResponse: Codable {
    let oauth: Oauth
    let userInfo: UserInfo
    let permissions: [String]
    let apiVersion: String
    let showPasswordPrompt: Bool
}

// MARK: - Oauth
struct Oauth: Codable {
    let accessToken: String
    let expiresIn: Int
    let tokenType: String
    let refreshToken: String

    enum CodingKeys: String,CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
    }
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let personalNo: Int
    let firstName, lastName, displayName: String
    let active: Bool
    let businessUnit: String
}
