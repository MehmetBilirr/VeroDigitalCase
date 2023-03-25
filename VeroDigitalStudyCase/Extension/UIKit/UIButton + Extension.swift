//
//  UIButton + Extension.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import Foundation


import UIKit

extension UIButton {
  func configureStyleTitleButton(title:String,titleColor:UIColor,backgroundClr:UIColor,cornerRds:CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    setTitle(title, for: .normal)
    setTitleColor(titleColor, for: .normal)
    backgroundColor = backgroundClr
    clipsToBounds = true
    layer.cornerRadius = cornerRds ?? 0
    
  }

}
