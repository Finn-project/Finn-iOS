//
//  NetworkModels.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

enum Network {
  static let hostURL: String = "https://himanmen.com"
  
  enum Auth {
    static let signUpURL: String = Network.hostURL + "/user/"
    static let loginURL: String = Network.hostURL + "/user/login/"
  }
}


