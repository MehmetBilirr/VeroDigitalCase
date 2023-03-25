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
    
        guard let request = createRequest(route: .getData, method: .get, parameters: nil) else {return}
       
        webService.request(request: request, route: .getData, method: .get, parameters: nil, completion: completion)
        
    }
    

    
    private func createRequest (route: Route, method: Method, parameters:[String:Any]?) -> URLRequest? {
        
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asURL else {return nil}
        guard let accessToken = UserDefaults.standard.string(forKey: "access_token") else {return nil}
        var urlRequest = URLRequest(url: url)
        let headers = [
          "Authorization": "Bearer \(accessToken)",
          "Content-Type": "application/json"
        ]
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        if let params = parameters {
            
            switch method {
            case .post,.delete,.patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                
                urlRequest.httpBody = bodyData
                
            default:
                break
            }
        }
        return urlRequest
    }
}
