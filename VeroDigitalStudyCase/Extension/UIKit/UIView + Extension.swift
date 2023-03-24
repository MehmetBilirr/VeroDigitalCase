//
//  UIView + Extension.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import Foundation
import UIKit

extension UIView {

    public var width:CGFloat {
        return self.frame.size.width
    }

    public var height:CGFloat {
        return self.frame.size.height
    }

    public var top:CGFloat {
        return self.frame.origin.y
    }

    public var bottom:CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }

    public var left:CGFloat {
        return self.frame.origin.x
    }

    public var right:CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }

    func configureBetweenView(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemFill
        heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

}


extension UIView {

  func addBottomLayer(_ color:UIColor,_ width:CGFloat){
          let border = CALayer()
          let width = CGFloat(1.0)
          border.backgroundColor = color.cgColor
          border.frame = CGRect(x: 0, y: self.bottom, width:  self.width, height: width)
          self.layer.addSublayer(border)
      }

}
