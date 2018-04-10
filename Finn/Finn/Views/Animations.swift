//
//  Animations.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 6..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

//MARK:- shaky animation for textFields in LoginFlow
extension UITextField {
  func shake() {
    
    //MARK: sublayer needs to be fixed, should be inserted
    self.layer.sublayers![0].backgroundColor = UIColor.red.cgColor
    
    UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: [.autoreverse], animations: {
      
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
        self.center.x -= 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.20, relativeDuration: 0.50, animations: {
        self.center.x += 32
      })
      
      UIView.addKeyframe(withRelativeStartTime: 0.70, relativeDuration: 0.25, animations: {
        self.center.x -= 32
      })
      
    }, completion: { _ in
      self.center.x += 16
      self.layer.sublayers![0].backgroundColor = UIColor.white.cgColor
    })
  }
}
