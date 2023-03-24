//
//  Token.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import Foundation

struct Token:Codable {
    
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String
    
}
