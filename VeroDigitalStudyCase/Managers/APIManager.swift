//
//  APIManager.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import Foundation

protocol APIManagerInterface {
    func getData(completion:@escaping(Result<[TaskResponse],Error>) -> Void)
}

class APIManager:APIManagerInterface {
    
    static let shared = APIManager()
    init(){}
    
    
    func getData(completion:@escaping(Result<[TaskResponse],Error>) -> Void){
        WebService.shared.request(route: .getData, method: .get, parameters: nil, completion: completion)
        
    }
    
}
