//
//  ConvenientViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class ConvenientViewController: UIViewController {
  
  //MARK: GO TO UploadIntro
  @IBAction func backToIntro(_ sender: Any){
    self.navigationController?.popToRootViewController(animated: true)
  }
  //MARK: IBOutlets
  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
extension ConvenientViewController: UITableViewDelegate{
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0{
      return 4
    }else {
      return 3
    }
  }
}

//MARK: amenity goods & amenity Facilities
let amenityGoods: [String] = ["전자렌지", "냉장고", "컴퓨터", "에어컨"]
let amenities: [String] = ["엘리베이터", "에스컬레이터", "세탁기"]
//MARK: UITableViewDataSource
extension ConvenientViewController: UITableViewDataSource{
  
  //MARK: Setting cell data
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    if indexPath.section == 0 {
      cell.textLabel?.text = amenityGoods[indexPath.row]
    }else{
      cell.textLabel?.text = amenities[indexPath.row]
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
    }else{
      cell.accessoryType = .checkmark
    }
  }
}
