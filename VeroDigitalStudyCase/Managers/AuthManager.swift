//
//  AuthManager.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 24.03.2023.
//

import Foundation

protocol AuthManagerInterface {
    func login(parameters:[String:Any],completion:@escaping(Result<AuthResponse,Error>)->Void)
    func refreshToken(completion: ((Bool) -> Void)?)
}

final class AuthManager:AuthManagerInterface {
    
    static let shared = AuthManager()
    let webService = WebService()
    init() {}
    private var refreshingToken = false
    var isSignedIn:Bool {
      return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expires_in") as? Date
    }
    
    private var shouldRefreshToken:Bool {
      //Refresh Token when 5 minutes left.
      guard let tokenExpirationDate = tokenExpirationDate else {
          return false
      }
      let currentDate = Date()
      let fiveMinutes: TimeInterval = 360
      return currentDate.addingTimeInterval(fiveMinutes) >= tokenExpirationDate
    }
    
    
    func login(parameters:[String:Any],completion:@escaping(Result<AuthResponse,Error>)->Void){
  
        guard let request = createRequest(route: .login, method: .post, parameters: parameters) else {
            
            completion(.failure(AppError.unknownError))
            
            return
            }
        
        webService.request(request: request, route: .login, method: .post, parameters: parameters, completion: completion)
    
        
    }
    
    func refreshToken(completion: ((Bool) -> Void)?) {
       guard !refreshingToken else { return }
       guard shouldRefreshToken else {
           completion?(true)
           return
       }
       guard let refreshToken = self.refreshToken else { return }
        
        guard let request = createRequest(route: .login, method: .post, parameters: Constants.parameters) else {return}
       refreshingToken = true

      //Body Parameters of Refresh Access token.
        URLSession.shared.dataTask(with:request) {  data, _, err in
       self.refreshingToken = false
       guard let data = data else {
           completion?(false)
           return
       }
       do {
           let result = try JSONDecoder().decode(AuthResponse.self, from: data)

           self.saveToken(result: result)
           completion?(true)
       } catch {
           print(err?.localizedDescription)
           completion?(false)
       }

     }.resume()

   }
    
    
    private func createRequest (route: Route, method: Method, parameters:[String:Any]?) -> URLRequest? {
        
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asURL else {return nil}
        let headers = [
          "Authorization": "Basic QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz",
          "Content-Type": "application/json"
        ]
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map {
                    URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlComponent?.url
                
            case .post,.delete,.patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                
                urlRequest.httpBody = bodyData
                
            }
        }
        return urlRequest
    }
    
    func saveToken(result:AuthResponse){
        UserDefaults.standard.setValue(result.oauth.accessToken, forKey: "access_token")
        UserDefaults.standard.setValue(result.oauth.refreshToken, forKey: "refresh_token")
        
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.oauth.expiresIn)), forKey: "expires_in")
        
    }
}
