//
//  Route.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 24.03.2023.
//

import Foundation

enum Route {

  static let baseUrl = "https://api.baubuddy.de"
  case login
  case getData
  
  var description:String {
    switch self {
        
    case.login:
        return "/index.php/login"
    case.getData:
        return "/dev/index.php/v1/tasks/select"
        
    }

  }

}
