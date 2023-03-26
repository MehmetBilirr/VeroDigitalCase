//
//  APIManager.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import Foundation


class APIManager {
    
    static let shared = APIManager()
    private let webService = WebService()
    init(){}
    
    
    func getData(completion:@escaping(Result<[TaskResponse],Error>) -> Void){
        webService.request(route: .getData, method: .get, parameters: nil, completion: completion)
        
    }
    
}
