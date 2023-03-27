//
//  AuthManager.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 24.03.2023.
//

import Foundation

protocol AuthManagerInterface {
    var isSignedIn:Bool{get}
    func login(parameters:[String:String],completion:@escaping(Result<AuthResponse,Error>)->Void)
    func saveToken(result:AuthResponse)
}

final class AuthManager:AuthManagerInterface {

    static let shared = AuthManager()
    init() {}
    
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
    
    
    func login(parameters:[String:String],completion:@escaping(Result<AuthResponse,Error>)->Void){
        WebService.shared.request(route: .login, parameters: parameters, completion: completion)
    }
    
    func saveToken(result:AuthResponse){
        UserDefaults.standard.setValue(result.oauth.accessToken, forKey: "access_token")
        UserDefaults.standard.setValue(result.oauth.refreshToken, forKey: "refresh_token")
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.oauth.expiresIn)), forKey: "expires_in")
    }
}
