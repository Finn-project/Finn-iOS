//
//  HouseDetailViewController.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 16..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class HouseDetailViewController: UITableViewController {
  
  @IBOutlet weak var detailImg: UIImageView!
  @IBOutlet weak var houseTitle: UITextView!
  @IBOutlet weak var hostName: UILabel!
  @IBOutlet weak var hostProfileImg: UIImageView!
  @IBOutlet weak var guestImg: UIImageView!
  @IBOutlet weak var roomImg: UIImageView!
  @IBOutlet weak var bedImg: UIImageView!
  @IBOutlet weak var bathroomImg: UIImageView!
  @IBOutlet weak var guestCount: UILabel!
  @IBOutlet weak var roomCount: UILabel!
  @IBOutlet weak var bedCount: UILabel!
  @IBOutlet weak var bathroomCount: UILabel!
  @IBOutlet weak var roomInfomationText: UITextView!
  @IBOutlet var facilities: [UIImageView]!
  @IBOutlet var amenities: [UIImageView]!
  @IBOutlet weak var detailMapView: MKMapView!
  //MARK:- Internal Data property
  var house: House!
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    
    drawImg()
    houseTitle.text = house.name
    hostName.text = house.host.userName
    self.guestCount.text = String(house.peopleCount)
    self.roomCount.text = String(house.roomCount)
    self.bedCount.text = String(house.bedCount)
    self.bathroomCount.text = String(house.bathroomCount)
    self.roomInfomationText.text = house.description
    
    for i in house.facilities {
      if facilities[i-1].tag == i {
        facilities[i-1].alpha = 1
      } else {
        facilities[i-1].alpha = 0.2
      }
    }
    
    for i in house.amenities {
      if amenities[i-1].tag == i {
        amenities[i-1].alpha = 1
      } else {
        amenities[i-1].alpha = 0.2
      }
    }
  }
}

extension HouseDetailViewController {
  func drawImg() {
    self.hostProfileImg.image = UIImage(named: house.host.images.profileImg)
    Alamofire
      .request(house.houseImages[0])
      .validate()
      .responseData { (response) in
        switch response.result {
        case .success:
          let img = UIImage(data: response.data!)
          self.detailImg.image = img
        case .failure(let error):
          print("error: \(error.localizedDescription)")
        }
    }
    
    Alamofire
      .request(house.host.images.profileImg)
      .validate()
      .responseData { (response) in
        switch response.result {
        case .success:
          let img = UIImage(data: response.data!)
          self.hostProfileImg.image = img
        case .failure(let error):
          print("error: \(error.localizedDescription)")
        }
    }
  }
}


