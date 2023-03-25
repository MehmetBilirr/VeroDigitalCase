//
//  ErrorResponse.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import Foundation


import Foundation

// MARK: - PlaylistDetailsResponse
struct ErrorResponse: Codable {
    let error: ApiError
}

// MARK: - Error
struct ApiError: Codable {
    let code: Int
    let message: String
}
