//
//  NetworkModels.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

enum Network {
  static let hostURL: String = "http://dlighter.com"
  
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

struct City {
  var cityName: String = ""
  var latitude: Double = 0.0
  var longitude: Double = 0.0
  var cityImage: String = ""
  
}

let seoul: City = City(cityName: "Seoul", latitude: 37.566535, longitude: 126.97796919999996, cityImage: "seoul.jpeg")
let incheon: City = City(cityName: "Incheon", latitude: 37.4562557, longitude: 126.70520620000002, cityImage: "incheon.jpeg")
let gwangju: City = City(cityName: "Gwangju", latitude: 35.1595454, longitude: 126.85260119999998, cityImage: "gwangju.jpeg")
let daegu: City = City(cityName: "Daegu", latitude: 35.8714354, longitude: 128.601445, cityImage: "daegu.jpeg")
let busan: City = City(cityName: "Busan", latitude: 35.1795543, longitude: 29.07564160000004, cityImage: "busan.jpeg")
let jeju: City = City(cityName: "Jeju", latitude: 33.4890113, longitude: 126.49830229999998, cityImage: "jeju.jpeg")
let daejeon: City = City(cityName: "Daejeon", latitude: 36.3504119, longitude: 127.38454750000005, cityImage: "daejeon.jpeg")


