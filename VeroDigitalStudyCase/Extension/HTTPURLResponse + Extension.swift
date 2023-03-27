//
//  HTTPURLResponse + Extension.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 26.03.2023.
//

import Foundation

extension HTTPURLResponse {
     func isResponseOK() -> Bool {
      return (200...299).contains(self.statusCode)
     }
}
