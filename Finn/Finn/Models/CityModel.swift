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
  var nelatitude: Double = 0.0
  var nelongitude: Double = 0.0
  var swlatitude: Double = 0.0
  var swlongitude: Double = 0.0
}

let seoul: City = City(cityName: "Seoul", latitude: 37.566535, longitude: 126.97796919999996, cityImage: "seoul", nelatitude: 37.681003, nelongitude: 127.134144, swlatitude: 37.447669, swlongitude: 126.797190)
let incheon: City = City(cityName: "Incheon", latitude: 37.4562557, longitude: 126.70520620000002, cityImage: "incheon", nelatitude: 37.636554, nelongitude: 126.768075, swlatitude: 37.408372, swlongitude: 126.613923)
let gwangju: City = City(cityName: "Gwangju", latitude: 35.1595454, longitude: 126.85260119999998, cityImage: "gwangju", nelatitude: 35.253815, nelongitude: 126.996920, swlatitude: 35.064147, swlongitude: 126.672013)
let daegu: City = City(cityName: "Daegu", latitude: 35.8714354, longitude: 128.601445, cityImage: "daegu", nelatitude: 36.003699, nelongitude: 128.719820, swlatitude: 35.618415, swlongitude: 128.366665)
let busan: City = City(cityName: "Busan", latitude: 35.1795543, longitude: 29.07564160000004, cityImage: "busan", nelatitude: 35.380756, nelongitude: 139.248260, swlatitude: 36.080126, swlongitude: 128.858245)
let jeju: City = City(cityName: "Jeju", latitude: 33.4890113, longitude: 126.49830229999998, cityImage: "jeju", nelatitude: 35.556364, nelongitude: 126.822836, swlatitude: 33.219250, swlongitude: 126.251547)
let daejeon: City = City(cityName: "Daejeon", latitude: 36.3504119, longitude: 127.38454750000005, cityImage: "daejeon", nelatitude: 36.473360, nelongitude: 127.483212, swlatitude: 36.191083, swlongitude: 127.335732)

let cities: [City] = [seoul, incheon, gwangju, daegu, busan, jeju, daejeon]
