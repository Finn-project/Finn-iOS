//
//  NetworkModels.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

enum Network {
  static let hostURL: String = "http://delighter.com"
  
  enum Auth {
    static let signUpURL: String = Network.hostURL + "/user/"
    static let loginURL: String = Network.hostURL + "/user/login/"
    static let fbLoginURL: String = Network.hostURL + "/user/facebook-login/"
    static let logoutURL: String = Network.hostURL + "/user/logout/"
  }
  
  enum House {
    static let getHouseURL: String = Network.hostURL + "/house/"
    
  }
}


