//
//  CityModel.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 24..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

struct City {
  var cityName: String = ""
  var latitude: Double = 0.0
  var longitude: Double = 0.0
  var cityImage: String = ""
  
}

let seoul: City = City(cityName: "Seoul", latitude: 37.566535, longitude: 126.97796919999996, cityImage: "seoul")
let incheon: City = City(cityName: "Incheon", latitude: 37.4562557, longitude: 126.70520620000002, cityImage: "incheon")
let gwangju: City = City(cityName: "Gwangju", latitude: 35.1595454, longitude: 126.85260119999998, cityImage: "gwangju")
let daegu: City = City(cityName: "Daegu", latitude: 35.8714354, longitude: 128.601445, cityImage: "daegu")
let busan: City = City(cityName: "Busan", latitude: 35.1795543, longitude: 29.07564160000004, cityImage: "busan")
let jeju: City = City(cityName: "Jeju", latitude: 33.4890113, longitude: 126.49830229999998, cityImage: "jeju")
let daejeon: City = City(cityName: "Daejeon", latitude: 36.3504119, longitude: 127.38454750000005, cityImage: "daejeon")

let cities: [City] = [seoul, incheon, gwangju, daegu, busan, jeju, daejeon]
