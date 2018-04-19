//
//  CalendarData.swift
//  Finn
//
//  Created by 배지호 on 2018. 4. 19..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

struct Stack <T> {
  var list = [T] ()
  var isEmpty : Bool {
    return list.isEmpty
  }
  mutating func push(_ element: T) {
    list.append(element)
    
  }
  
  mutating func pop() -> T? {
    if !list.isEmpty {
      let index = list.count - 1
      let poppedValue = list.remove(at: index)
      return poppedValue
    } else {
      return nil
    }
  }
  
  func peek() -> T? {
    if !list.isEmpty {
      return list.last
    } else {
      return nil
    }
  }
}
