//
//  MockApiManager.swift
//  VeroDigitalStudyCaseTests
//
//  Created by Mehmet Bilir on 27.03.2023.
//

import Foundation
@testable import VeroDigitalStudyCase

class MockApiManager:APIManagerInterface {

    var invokedGetData = false
    var invokedGetDataCount = 0
    var stubbedGetDataCompletionResult: (Result<[TaskResponse], Error>, Void)?

    func getData(completion:@escaping(Result<[TaskResponse],Error>) -> Void) {
        invokedGetData = true
        invokedGetDataCount += 1
        if let result = stubbedGetDataCompletionResult {
            completion(result.0)
        }
    }
}

