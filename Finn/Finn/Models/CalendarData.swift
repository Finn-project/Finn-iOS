//
//  CalendarData.swift
//  Finn
//
//  Created by 배지호 on 2018. 4. 19..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

class Stack {
  var list: [String] = []
  var isEmpty : Bool {
    return list.isEmpty
  }
  func push(_ element: String) {
    list.append(element)
    list.sort()
    
  }
  
  func pop() -> String? {
    if !list.isEmpty {
      let index = list.count - 1
      let poppedValue = list.remove(at: index)
      return poppedValue
    } else {
      return nil
    }
  }
  
  func peek() -> String? {
    if !list.isEmpty {
      return list.last
    } else {
      return nil
    }
  }
}
