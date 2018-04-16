//
//  ConvenientViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class ConvenientViewController: UIViewController {
  var stepOne = HouseInfoStepOneForInternal()
  
  //MARK: GO TO UploadIntro
  @IBAction func backToIntro(_ sender: Any){
    var selectedAmenities: [String] = []
    var selectedFacilities: [String] = []
//    tableView.indexPathForSelectedRow?.forEach{print($0)}
    
//    tableView.indexPathsForSelectedRows?.forEach {
//      print("(\($0.section), \($0.row))")
//    }
    if let array = tableView.indexPathsForSelectedRows {
      array.forEach { (indexPath) in
        if (indexPath.section == 0) {
          selectedAmenities.append( String(indexPath.row) )
        } else if (indexPath.section == 1) {
          selectedFacilities.append( String(indexPath.row) )
        }
      }
    }
    if let rootVC = self.navigationController?.viewControllers[0] as? UploadFlowMainViewController {
//      rootVC.stepOne = <# whole struct #>
    }
    self.navigationController?.popToRootViewController(animated: true)
    
  }
  //MARK: IBOutlets
  @IBOutlet weak var tableView: UITableView!
  //MARK:- Internal Property
  var houseInfoData: [String: Any] = [:]
  var addressforupload = AddressForInternal()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    stepOne.address = addressforupload
//    stepOne.bathroomCount = houseInfoData[""] as!
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
//MARK: UITableViewDelegate -> numberOfSections & numberOfRowsInSection
extension ConvenientViewController {
  
  
}
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

//MARK: amenity goods & amenity Facilities
let amenities: [String] = ["TV", "에어컨", "전자렌지", "커피포트", "컴퓨터", "공기청정기"]
let facilities: [String] = ["수영장", "엘리베이터", "세탁소","노래방", "오락실", "온천"]
//MARK: UITableViewDataSource
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
  //MARK: When cell did select, accessoryType become checkmark or none
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) else { return }
    if cell.accessoryType == .checkmark{
      cell.accessoryType = .none
      cell.isSelected = false
    } else {
      cell.accessoryType = .checkmark
      cell.isSelected = true
    }
  }
}
