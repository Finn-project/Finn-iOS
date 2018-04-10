//
//  UserModels.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

let currentUserDictKey = "CurrentUser"

//MARK:- class only used in ProfileTabs
class UserProfile {
  
  var token: String = ""
  var userName: String = ""
  var email: String = ""
  var firstName: String = ""
  var lastName: String = ""
  var profileImg: String = ""
  var phoneNumber: String = ""
  
  var isHost: Bool = false
  var isFacebookUser: Bool = false
  var isEmailUser: Bool = false
  
  /// Only Called in Profile > Setting > Logout
  /// In setting, User instance exists
  func resetUserDefaults() {
    var info: [String: Any] = [:]
    
    info.updateValue("0000", forKey: "userName")
    info.updateValue("0000", forKey: "email")
    info.updateValue("0000", forKey: "phoneNumber")
    info.updateValue("0000", forKey: "firstName")
    info.updateValue("0000", forKey: "lastName")
    info.updateValue("0000", forKey: "profileImg")
    
    info.updateValue(false, forKey: "isHost")
    info.updateValue(false, forKey: "isEmailUser")
    info.updateValue(false, forKey: "isFacebookUser")
    
    info.updateValue("0000", forKey: "token")
    
    UserDefaults.standard.set(info, forKey: currentUserDictKey)
  }
  
}

//MARK:- retrieved UserData from server, including token
class User: Codable {
  var token: String = "0000"
  var userInfo: UserInfo
  
  enum CodingKeys: String, CodingKey {
    case token
    case userInfo = "user"
  }
  
  //MARK:- UserDefaults helper functions
  
  /// Only Called in signUp, login Views, where User instance exists
  func saveToUserDefaults() {
    var info: [String: Any] = [:]
    
    info.updateValue(self.userInfo.userName, forKey: "userName")
    info.updateValue(self.userInfo.phoneNumber, forKey: "phoneNumber")
    info.updateValue(self.userInfo.firstName, forKey: "firstName")
    info.updateValue(self.userInfo.lastName, forKey: "lastName")
    info.updateValue(self.userInfo.isHost, forKey: "isHost")
    info.updateValue(self.userInfo.isEmailUser, forKey: "isEmailUser")
    info.updateValue(self.userInfo.isFacebookUser, forKey: "isFacebookUser")
    
    //fb login returns nil in email Field
    if let tempEmail = self.userInfo.email {
      info.updateValue(tempEmail, forKey: "email")
    } else {
      info.updateValue("0000", forKey: "email")
    }
    
    if let profileImg = self.userInfo.profileImg {
      info.updateValue(profileImg, forKey: "profileImg")
    } else {
      // MARK: default img required
      info.updateValue("0000", forKey: "profileImg")
    }
    
    info.updateValue(self.token, forKey: "token")
    
    UserDefaults.standard.set(info, forKey: currentUserDictKey)
  }
  
  /// Called in any views
  /// - Returns: currentUser info dictionary
  class func loadTokenFromUserDefaults() -> String! {
    if let target = UserDefaults.standard.dictionary(forKey: currentUserDictKey),
      let token = target["token"] as? String,
      token != "0000" {
      return token
    }
    return nil
  }
  
  /// checks user defaults whether currentUser exists or not
  /// by token value
  /// - Returns: true or false
  class func checkCurrentUser() -> Bool {
    if let target = UserDefaults.standard.dictionary(forKey: currentUserDictKey),
      let token = target["token"] as? String,
      token != "0000" {
      return true
    }
    return false
  }
  
  class func getUserProfileFromUserDefaults() -> UserProfile? {
    
    //MARK: Refactor conditional statement here
    if self.checkCurrentUser() {
      guard let dict = UserDefaults.standard.dictionary(forKey: currentUserDictKey) else { return nil }
      
      let targetUserProfile = UserProfile()
      
      targetUserProfile.token = dict["token"] as! String
      targetUserProfile.userName = dict["userName"] as! String
      targetUserProfile.phoneNumber = dict["phoneNumber"] as! String
      targetUserProfile.firstName = dict["firstName"] as! String
      targetUserProfile.lastName = dict["lastName"] as! String
      targetUserProfile.profileImg = dict["profileImg"] as! String
      targetUserProfile.email = dict["email"] as! String
      
      targetUserProfile.isHost = dict["isHost"] as! Bool
      targetUserProfile.isEmailUser = dict["isEmailUser"] as! Bool
      targetUserProfile.isFacebookUser = dict["isFacebookUser"] as! Bool
      
      return targetUserProfile
    }
    return nil
  }
  
}

//MARK:- userinfo from server
class UserInfo: Codable {
  var pk: Int = 0
  var userName: String = "0000"
  var email: String! // facebook login returns nil in email
  var phoneNumber: String = "0000"
  var firstName: String = "0000"
  var lastName: String = "0000"
  var profileImg: String! // all login type returns String!
  var isHost: Bool = false
  var isEmailUser: Bool = false
  var isFacebookUser: Bool = false
  
  enum CodingKeys: String, CodingKey {
    case pk
    case userName = "username"
    case phoneNumber = "phone_num"
    case email
    case firstName = "first_name"
    case lastName = "last_name"
    case profileImg = "img_profile"
    case isHost = "is_host"
    case isEmailUser = "is_email_user"
    case isFacebookUser = "is_facebook_user"
  }
}
