//
//  MockAuthManager.swift
//  VeroDigitalStudyCaseTests
//
//  Created by Mehmet Bilir on 26.03.2023.
//

import Foundation
@testable import VeroDigitalStudyCase

class MockAuthManager:AuthManagerInterface {

    var invokedIsSignedInGetter = false
    var invokedIsSignedInGetterCount = 0
    var stubbedIsSignedIn: Bool! = false

    var isSignedIn:Bool {
        invokedIsSignedInGetter = true
        invokedIsSignedInGetterCount += 1
        return stubbedIsSignedIn
    }

    var invokedLogin = false
    var invokedLoginCount = 0
    var invokedLoginParameters: (parameters: [String: String], Void)?
    var invokedLoginParametersList = [(parameters: [String: String], Void)]()
    var stubbedLoginCompletionResult: (Result<AuthResponse, Error>, Void)?

    func login(parameters:[String:String],completion:@escaping(Result<AuthResponse,Error>)->Void) {
        invokedLogin = true
        invokedLoginCount += 1
        invokedLoginParameters = (parameters, ())
        invokedLoginParametersList.append((parameters, ()))
        if let result = stubbedLoginCompletionResult {
            completion(result.0)
        }
    }

    var invokedSaveToken = false
    var invokedSaveTokenCount = 0
    var invokedSaveTokenParameters: (result: AuthResponse, Void)?
    var invokedSaveTokenParametersList = [(result: AuthResponse, Void)]()

    func saveToken(result:AuthResponse) {
        invokedSaveToken = true
        invokedSaveTokenCount += 1
        invokedSaveTokenParameters = (result, ())
        invokedSaveTokenParametersList.append((result, ()))
    }
}
