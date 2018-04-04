//
//  UserModels.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

let currentUserKey = "CurrentUser"

//MARK:- retrieved UserData from server, including token
class User: Codable {
  var token: String = "0000"
  var userInfo: UserInfo
  
  enum CodingKeys: String, CodingKey {
    case token
    case userInfo
  }
  
  //MARK:- UserDefaults helper functions
  
  /// checks user defaults whether currentUser exists or not
  /// by token value
  /// - Returns: true or false
  private func checkCurrentUser() -> Bool {
    if let target = UserDefaults.standard.dictionary(forKey: currentUserKey),
       let token = target["token"] as? String,
       token != "0000" {
      return true
    }
    return false
  }
  
  
  /// Only Called in signUp, login Views, where User instance exists
  func saveToUserDefaults() {
    var info: [String: Any] = [:]
    
    info.updateValue(self.userInfo.pk, forKey: "pk")
    info.updateValue(self.userInfo.userName, forKey: "userName")
    info.updateValue(self.userInfo.email, forKey: "email")
    info.updateValue(self.userInfo.phoneNumber, forKey: "phoneNumber")
    info.updateValue(self.userInfo.firstName, forKey: "firstName")
    info.updateValue(self.userInfo.lastName, forKey: "lastName")
    info.updateValue(self.userInfo.profileImg, forKey: "profileImg")
    
    info.updateValue(self.token, forKey: "token")
    
    UserDefaults.standard.set(info, forKey: currentUserKey)
  }
  
  /// Only Called in Profile > Setting > Logout
  /// In setting, User instance exists
  func resetUserDefaults() {
    var info: [String: Any] = [:]
    
    info.updateValue(0, forKey: "pk")
    info.updateValue("0000", forKey: "userName")
    info.updateValue("0000", forKey: "email")
    info.updateValue("0000", forKey: "phoneNumber")
    info.updateValue("0000", forKey: "firstName")
    info.updateValue("0000", forKey: "lastName")
    info.updateValue("0000", forKey: "profileImg")
    
    info.updateValue("0000", forKey: "token")
    
    UserDefaults.standard.set(info, forKey: currentUserKey)
  }
  
// let username = UserDefaults.standard.value(forKey: standardIDKey) as? String,
  
  /// Called in any views
  /// - Returns: currentUser info dictionary
  class func loadTokenFromUserDefaults() -> String! {
    if let target = UserDefaults.standard.dictionary(forKey: currentUserKey),
      let token = target["token"] as? String,
      token != "0000" {
      return token
    }
    return nil
  }
  
}

//MARK:- clientSide user info, includes userDefaults helper functions
class UserInfo: Codable {
  var pk: Int = 0
  var userName: String = "0000"
  var email: String = "0000"
  var phoneNumber: String = "0000"
  var firstName: String = "0000"
  var lastName: String = "0000"
  var profileImg: String = "0000"
  
  enum CodingKeys: String, CodingKey {
    case pk = "id"
    case userName = "username"
    case phoneNumber = "phone_num"
    case email
    case firstName = "first_name"
    case lastName = "last_name"
    case profileImg = "img_profile"
  }
}
