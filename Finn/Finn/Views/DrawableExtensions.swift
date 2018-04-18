//
//  DrawableExtensions.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 6..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation
//MARK:- themeColor
let originColor: UIColor = UIColor.init(named: "ThemeColor")!
//MARK: UITextField
extension UITextField {
  func borderBottom(height: CGFloat, color: UIColor) {
    let border = CALayer()
    border.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: height)
    border.backgroundColor = color.cgColor
    self.layer.insertSublayer(border, at: 0)
  }
  
  func drawBottomBorder(backColor: UIColor, withColor: UIColor) {
    self.layer.backgroundColor = backColor.cgColor
    self.layer.masksToBounds = false
    
    self.layer.shadowColor = withColor.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    self.layer.shadowOpacity = 1.0
    self.layer.shadowRadius = 0.0
  }
  
  func removeBottomBorder() {
    self.layer.shadowOpacity = 0.0
  }
}

//MARK: UIButton
extension UIButton {
  func btnCustom() {
    let btn = CALayer()
    btn.cornerRadius = self.frame.width / 2
    btn.borderWidth = 2
    btn.borderColor = UIColor.black.cgColor
    btn.backgroundColor = UIColor.white.cgColor
    self.layer.addSublayer(btn)
  }
 
}
