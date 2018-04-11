//
//  HouseModel.swift
//  Finn
//
//  Created by 최현호 on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

//MARK:- retrieved house data from server
class House: Codable {
  var pk: Int = 0
  var houseInfoStepOne: HouseInfoStepOne
  var houseInfoStepTwo: HouseInfoStepTwo
  var houseInfoStepThree: HouseInfoStepThree
  var host: UserInfo
  var createdDate: Int = 0
  var modifiedDate: Int = 0
  
  enum Codingkeys: String, CodingKey {
    case pk
    case createdDate = "created_date"
    case modifiedDate = "modified_date"
  }
}
//MARK:- UploadFlow Step 1.
class HouseInfoStepOne: Codable {
  var houseType: String = "0000"
  var roomCount: Int = 0
  var bedCount: Int = 0
  var bathroomCount: Int = 0
  var peopleCount: Int = 0
  var country: String = "0000"
  var address: Address
  var amenities: [Amenities] = []
  var facilities: [Facilities] = []
  
  enum Codingkeys: String, CodingKey {
    case houseType = "house_type"
    case roomCount = "room"
    case bedCount = "bed"
    case bathroomCount = "bathroom"
    case peopleCount = "personnel"
    case coutry
    
  }
}
//MARK:- Address, related to step 1.
class Address: Codable {
  var city: String = "0000"
  var district: String = "0000"
  var dong: String = "0000"
  var firstDetailAddress: String = "0000"
  var secondDetailAddress: String = "0000"
  var latitude: Double = 0.0
  var longitude: Double = 0.0
  
  enum Codingkeys: String, CodingKey {
    case city
    case district
    case dong
    case firstDetailAddress = "address1"
    case secondDetailAddress = "address2"
    case latitude
    case longitude
  }
}
//MARK:- amenities, related to step 1.
class Amenities: Codable {
  var tv: String = "0000"
  var airConditioner: String = "0000"
  var oven: String = "0000"
  var coffeepot: String = "0000"
  var computer: String = "0000"
  var airCleaner: String = "0000"
  
  enum Codingkeys: Int, CodingKey {
    case tv = 1
    case airConditioner = 2
    case oven = 3
    case coffepot = 4
    case computer = 5
    case airCleaner = 6
  }
}
//MARK:- facilities, related to step 1.
class Facilities: Codable {
  var pool: String = "0000"
  var elevator: String = "0000"
  var laundry: String = "0000"
  var karaoke: String = "0000"
  var gameRoom: String = "0000"
  var hotSpring: String = "0000"
  enum Codingkeys: Int, CodingKey {
    case pool = 1
    case elevator = 2
    case laundry = 3
    case karaoke = 4
    case gameRoom = 5
    case hotSpring = 6
  }
}
//MARK:- UploadFlow Step 2.
class HouseInfoStepTwo: Codable {
  var houseName: String = "0000"
  //images
  var houseDescription: String = "0000"
  
  enum Codingkeys: String, CodingKey {
    case houseName = "name"
    case houseDescription = "description"
  }
}
//MARK:- UploadFlow Step 3.
class HouseInfoStepThree: Codable {
  var minCheckInDays: Int = 0
  var maxCheckInDays: Int = 0
  var maxCheckInRange: Int = 0
  var accommodationFee: Int = 0
  
  enum Codingkeys: String, CodingKey {
    case minCheckInDays = "minimum_check_in_duration"
    case maxCheckInDays = "maximum_check_in_duration"
    case maxCheckInRange = "maximum_check_in_range"
    case accommodationFee = "price_per_night"
  }
}



