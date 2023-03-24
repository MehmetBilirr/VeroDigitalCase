//
//  String + Extension.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 24.03.2023.
//

import Foundation

extension String {

  var asURL:URL? {
    return URL(string: self)
  }
}
