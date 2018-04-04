//
//  UserModels.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

//MARK:- retrieved User data from server, including token
class UserWrapper: Codable {
  var token: String = ""
  var user: User
  
  enum CodingKeys: String, CodingKey {
    case token
    case user
  }
}

//MARK:- clientSide user data, includes userDefaults helper functions
class User: Codable {
  var pk: Int = 0
  var userName: String = ""
  var email: String = ""
  var firstName: String = ""
  var lastName: String = ""
  var profileImg: String = ""
  
  enum CodingKeys: String, CodingKey {
    case pk = "id"
    case userName = "username"
    case email
    case firstName = "first_name"
    case lastName = "last_name"
    case profileImg = "profile_img"
  }
  
  //MARK: UserDefaults helper functions
  
}
