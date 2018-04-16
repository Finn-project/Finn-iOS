//
//  UploadIntroViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class UploadIntroViewController: UIViewController {
  
  
  
  
  //MARK:-  IBOultlets
  @IBOutlet weak var roomTypeTf: UITextField!
  @IBOutlet weak var roomCountTf: UITextField!
  @IBOutlet weak var bedCountTf: UITextField!
  @IBOutlet weak var bathCountTf: UITextField!
  @IBOutlet weak var allowedPeopleTf: UITextField!
  
  //MARK:- picker init
  let roomTypePicker = UIPickerView()
  let roomCountPicker = UIPickerView()
  let bedCountPicker = UIPickerView()
  let bathCountPicker = UIPickerView()
  let allowedPeoplePicker = UIPickerView()
  
  //MARK:- Dummy Data
  let roomTypeData = ["주택", "아파트", "원룸"]
  let roomCountData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
  let bedCountData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16+"]
  let bathCountData = ["1", "2", "3", "4", "5", "6", "7", "8"]
  let allowedPeopleData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16+"]
  
  //MARK:- Internal Property
  var houseInfoData: [String: Any] = [:]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(houseInfoData)
    roomTypePicker.delegate = self
    roomTypePicker.dataSource = self
    roomCountPicker.delegate = self
    roomCountPicker.dataSource = self
    bedCountPicker.delegate = self
    bedCountPicker.dataSource = self
    bathCountPicker.delegate = self
    bathCountPicker.dataSource = self
    allowedPeoplePicker.delegate = self
    allowedPeoplePicker.dataSource = self
    
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = UIColor.black
    toolBar.sizeToFit()
    
    let doneButton = UIBarButtonItem(title: "완료", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.doneAct(_:)))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    
    
    toolBar.setItems([spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    roomTypeTf.inputAccessoryView = toolBar
    roomCountTf.inputAccessoryView = toolBar
    bedCountTf.inputAccessoryView = toolBar
    bathCountTf.inputAccessoryView = toolBar
    allowedPeopleTf.inputAccessoryView = toolBar
    
    roomTypeTf.inputView = roomTypePicker
    roomCountTf.inputView = roomCountPicker
    bedCountTf.inputView = bedCountPicker
    bathCountTf.inputView = bathCountPicker
    allowedPeopleTf.inputView = allowedPeoplePicker
    // Do any additional setup after loading the view.
  }
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    roomTypeTf.borderBottom(height: 1.0, color: .lightGray)
    roomCountTf.borderBottom(height: 1.0, color: .lightGray)
    bedCountTf.borderBottom(height: 1.0, color: .lightGray)
    bathCountTf.borderBottom(height: 1.0, color: .lightGray)
    allowedPeopleTf.borderBottom(height: 1.0, color: .lightGray)
  }
  //MARK:- done Action
  @objc func doneAct(_ sender: Any) {
    //머리가 안돌아감, 수정 필요
    roomTypeTf.inputView?.removeFromSuperview()
    roomTypeTf.inputAccessoryView?.removeFromSuperview()
    roomCountTf.inputView?.removeFromSuperview()
    roomCountTf.inputAccessoryView?.removeFromSuperview()
    bedCountTf.inputView?.removeFromSuperview()
    bedCountTf.inputAccessoryView?.removeFromSuperview()
    bathCountTf.inputView?.removeFromSuperview()
    bathCountTf.inputAccessoryView?.removeFromSuperview()
    allowedPeopleTf.inputView?.removeFromSuperview()
    allowedPeopleTf.inputAccessoryView?.removeFromSuperview()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let roomAddressVC = segue.destination as? RoomAddressViewController else {return}
    uploadIntroData()
    roomAddressVC.houseInfoData = houseInfoData
    
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  

  
}
extension UploadIntroViewController {
  func uploadIntroData(){
    guard let roomType = roomTypeTf.text else {return}
    houseInfoData.updateValue(roomType, forKey: "houseType")
    
    guard let roomCount: Int = Int(roomCountTf.text!) else {return}
    houseInfoData.updateValue(roomCount, forKey: "roomCount")
    guard let bedCount: Int = Int(bedCountTf.text!) else {return}
    houseInfoData.updateValue(bedCount, forKey: "bedCount")
    guard let bathCount: Int = Int(bathCountTf.text!) else {return}
    houseInfoData.updateValue(bathCount, forKey: "bathroomCount")
    guard let allowedPeople: Int = Int(allowedPeopleTf.text!) else {return}
    houseInfoData.updateValue(allowedPeople, forKey: "peopleCount")
  }
}

//MARK: Textfield Delegate
extension UploadIntroViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    return true
  }
  
}
//MARK:- PickerView Delegate
extension UploadIntroViewController: UIPickerViewDelegate {
  
}

//MARKL:- PickerView Datasource
extension UploadIntroViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView == roomTypePicker{
      return roomTypeData.count
    }else if pickerView == roomCountPicker {
      return roomCountData.count
    }else if pickerView == bedCountPicker {
      return bedCountData.count
    }else if pickerView == bathCountPicker {
      return bathCountData.count
    }else {
      return allowedPeopleData.count
    }
  }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView == roomTypePicker {
      return roomTypeData[row]
    }
    if pickerView == roomCountPicker {
      return roomCountData[row]
    }else if pickerView == bedCountPicker {
      return bedCountData[row]
    }else if pickerView == bathCountPicker {
      return bathCountData[row]
    }else {
      return allowedPeopleData[row]
    }
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == roomTypePicker {
      roomTypeTf.text = roomTypeData[0]
    }else if pickerView == roomCountPicker {
      roomCountTf.text = roomCountData[row]
    }else if pickerView == bedCountPicker {
      bedCountTf.text = bedCountData[row]
    }else if pickerView == bathCountPicker {
      bathCountTf.text = bathCountData[row]
    }else {
      allowedPeopleTf.text = allowedPeopleData[row]
    }
  }
}

