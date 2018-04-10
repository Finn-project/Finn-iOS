//
//  DrawableExtensions.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 6..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

//MARK: UITextField
extension UITextField {
  func borderBottom(height: CGFloat, color: UIColor) {
    let border = CALayer()
    border.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: height)
    border.backgroundColor = color.cgColor
    self.layer.addSublayer(border)
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
