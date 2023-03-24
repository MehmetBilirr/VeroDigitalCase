//
//  UILabel + Extension.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import Foundation

import UIKit

extension UILabel {

  func configureStyle(size:CGFloat,weight:UIFont.Weight,color:UIColor){

    translatesAutoresizingMaskIntoConstraints = false
    textAlignment = .left
    font = .systemFont(ofSize: size, weight: weight)
    textColor = color
    numberOfLines = 0
    lineBreakMode = .byWordWrapping
  }
}
