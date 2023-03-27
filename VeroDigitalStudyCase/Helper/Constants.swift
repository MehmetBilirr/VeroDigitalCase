//
//  Constants.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 24.03.2023.
//

import Foundation

struct Constants {

    static  let authParameters : [String : String] = [
    "Authorization": "Basic QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz",
    "Content-Type": "application/json"
  ]
    
    
    static  var taskParameters : [String : String]  {
        
        guard let accessToken = UserDefaults.standard.string(forKey: "access_token") else {return ["":""]}
        return [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
          ]
    }
    
    

}
