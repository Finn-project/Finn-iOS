//
//  HouseModel.swift
//  Finn
//
//  Created by 최현호 on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

//MARK:- amenity goods & amenity Facilities Dummy Data
let amenities: [String] = ["TV", "에어컨", "전자렌지", "커피포트", "컴퓨터", "공기청정기"]
let facilities: [String] = ["수영장", "엘리베이터", "세탁소","노래방", "오락실", "온천"]

class HouseInfoForInternal {
  var pk: Int = 0
  var houseInfoStepOneForInternal: HouseInfoStepOneForInternal = HouseInfoStepOneForInternal()
 //var houseInfoStepTwoForInternal: HouseInfoStepTwoForInternal
 //var houseInfoStepThreeForInternal: HouseInfoStepThreeForInternal
  
  
}
class HouseInfoStepOneForInternal {
  var houseType: String = "0000"
  var roomCount: Int = 0
  var bedCount: Int = 0
  var bathroomCount: Int = 0
  var peopleCount: Int = 0
  var country: String = "0000"
  var address: AddressForInternal = AddressForInternal()
  var amenities: [Int] = []
  var facilities: [Int] = []

}
class AddressForInternal {
  var city: String = "0000"
  var district: String = "0000"
  var dong: String = "0000"
  var firstDetailAddress: String = "0000"
  var secondDetailAddress: String = "0000"
  var latitude: Double = 0.0
  var longitude: Double = 0.0

}

class HouseInfoStepTwoForInternal {
  
}
class HouseInfoStepThreeForInternal {
  
}



class ListOfHouse: Codable {
  var count: Int = 0
  var next: String!
  var previous: String!
  var results: [House] = []
  
  enum CodingKeys: String, CodingKey {
    case count
    case next
    case previous
    case results
  }
}


//MARK:- retrieved house data from server
class House: Codable {
  
  var pk: Int = 0
  var houseType: String = "0000"
  var roomCount: Int = 0
  var bedCount: Int = 0
  var bathroomCount: Int = 0
  var peopleCount: Int = 0
  var country: String = "0000"
  var city: String = "0000"
  var district: String = "0000"
  var dong: String = "0000"
  var firstDetailAddress: String = "0000"
  var latitude: String = "0000"
  var longitude: String = "0000"
  var amenities: [Int] = []
  var facilities: [Int] = []
  var minCheckInDays: Int = 0
  var maxCheckInDays: Int = 0
  var maxCheckInRange: Int = 0
  var accommodationFee: Int = 0
  var host: UserInfo!
  var createdDate: String = "0000"
  var modifiedDate: String = "0000"
  var disableDays: [String] = []
  var reserveDays: [String] = []
  var imgCover: String!
  var imgCoverThumbnail: String!
  var houseImages: [String] = []
  
  enum CodingKeys: String, CodingKey {
    case pk
    case houseType = "house_type"
    case roomCount = "room"
    case bedCount = "bed"
    case bathroomCount = "bathroom"
    case peopleCount = "personnel"
    case country
    case amenities
    case facilities
    case minCheckInDays = "minimum_check_in_duration"
    case maxCheckInDays = "maximum_check_in_duration"
    case maxCheckInRange = "maximum_check_in_range"
    case accommodationFee = "price_per_night"
    case createdDate = "created_date"
    case modifiedDate = "modified_date"
    case city
    case district
    case dong
    case firstDetailAddress = "address1"
    case latitude
    case longitude
    case host
    case disableDays = "disable_days"
    case reserveDays = "reserve_days"
    case imgCover = "img_cover"
    case imgCoverThumbnail = "img_cover_thumbnail"
    case houseImages = "house_images"
  }
}
