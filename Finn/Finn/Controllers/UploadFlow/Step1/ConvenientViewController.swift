//
//  ConvenientViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class ConvenientViewController: UIViewController {
  
  //MARK:- IBOutlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var saveBtn: UIButton!
  
  //MARK:- Internal property
  var houseInfoData: [String: Any] = [:]
  var addressforupload = AddressForInternal()
  var stepOne = HouseInfoStepOneForInternal()
  
  
  
  //MARK:- GO TO UploadIntro
  @IBAction func backToIntro(_ sender: Any){
    var selectedAmenities: [Int] = []
    var selectedFacilities: [Int] = []

    if let array = tableView.indexPathsForSelectedRows {
      array.forEach { (indexPath) in
        if (indexPath.section == 0) {
          selectedAmenities.append( indexPath.row + 1 )
          
          print("amenities : ", selectedAmenities)
        } else if (indexPath.section == 1) {
          selectedFacilities.append( indexPath.row + 1 )
          print("facilities : ", selectedFacilities)
        }
      }
    }
    if let rootVC = self.navigationController?.viewControllers[0] as? UploadFlowMainViewController {
      stepOneUploadForInternal()
      stepOne.amenities = selectedAmenities
      stepOne.facilities = selectedFacilities
      rootVC.stepOne = self.stepOne
    }
    self.navigationController?.popToRootViewController(animated: true)
    
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    
    btnDisable()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
 
  
}

//MARK:- ConvenientVC Extension
extension ConvenientViewController {
  //MARK: save to Internal
  func stepOneUploadForInternal() {
    stepOne.address = addressforupload
    stepOne.houseType = houseInfoData["houseType"] as! String
    stepOne.bedCount = houseInfoData["bedCount"] as! Int
    stepOne.bathroomCount = houseInfoData["bathroomCount"] as! Int
    stepOne.roomCount = houseInfoData["roomCount"] as! Int
    stepOne.peopleCount = houseInfoData["peopleCount"] as! Int
    stepOne.country = houseInfoData["country"] as! String
  }
  func btnDisable() {
    saveBtn.backgroundColor = .white
    saveBtn.setTitleColor(originColor, for: .normal)
    saveBtn.layer.borderColor = originColor.cgColor
    saveBtn.setTitle("저장", for: .normal)
    saveBtn.layer.borderWidth = 1
    saveBtn.isEnabled = false
  }
  func btnEnable() {
    saveBtn.backgroundColor = originColor
    saveBtn.setTitleColor(.white, for: .normal)
    saveBtn.setTitle("저장", for: .normal)
    saveBtn.layer.borderWidth = 0
    saveBtn.isEnabled = true
  }
  
}

//MARK:- UITableViewDelegate -> numberOfSections & numberOfRowsInSection
extension ConvenientViewController: UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0{
      return 6
    }else {
      return 6
    }
  }
}


//MARK:- UITableViewDataSource
extension ConvenientViewController: UITableViewDataSource{
  
  //MARK: Setting cell data
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    if indexPath.section == 0 {
      cell.textLabel?.text = amenities[indexPath.row]
      cell.isSelected = false
    } else {
      cell.textLabel?.text = facilities[indexPath.row]
      cell.isSelected = false
    }
    return cell
  }
  //MARK: Setting section title
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    var title: String?
    if section == 0 {
      title = "편의 물품"
    }else{
      title = "편의 시설"
    }
    
    
    return title
  }
  //MARK:- When cell did select, accessoryType become checkmark or none
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) else { return }
    if cell.accessoryType == .checkmark{
      cell.accessoryType = .none
      cell.isSelected = false
    } else {
      cell.accessoryType = .checkmark
      cell.isSelected = true
    }
    btnEnable()
  }
}
