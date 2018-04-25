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
  @IBOutlet weak var swimmingPoolImg: UIImageView!
  @IBOutlet weak var elevatorImg: UIImageView!
  @IBOutlet weak var laundryImg: UIImageView!
  @IBOutlet weak var karaokeImg: UIImageView!
  @IBOutlet weak var arcadeImg: UIImageView!
  @IBOutlet weak var spaImg: UIImageView!
  @IBOutlet weak var tvImg: UIImageView!
  @IBOutlet weak var airConditionerImg: UIImageView!
  @IBOutlet weak var microwaveImg: UIImageView!
  @IBOutlet weak var coffeePotImg: UIImageView!
  @IBOutlet weak var computerImg: UIImageView!
  @IBOutlet weak var airCleanerImg: UIImageView!
  @IBOutlet weak var roomInfomationText: UITextView!
  @IBOutlet weak var detailMapView: MKMapView!
  
  //MARK:- Internal Data property
  var house: House!
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    
    drawImg()
    houseTitle.text = house.name
    hostName.text = house.host.userName
    guard let peopleCount: String = String(house.peopleCount) else { return }
    self.guestCount.text = peopleCount
    guard let myRoomCount: String = String(house.roomCount) else { return }
    self.roomCount.text = myRoomCount
    guard let bed: String = String(house.bedCount) else { return }
    self.bedCount.text = bed
    guard let bath: String = String(house.bathroomCount) else { return }
    self.bathroomCount.text = bath
    self.roomInfomationText.text = house.description
    
    
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


