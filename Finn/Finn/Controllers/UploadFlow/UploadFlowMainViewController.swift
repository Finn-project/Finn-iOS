//
//  UploadFlowMainViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 3..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class UploadFlowMainViewController: UIViewController {
  
  //MARK:- IBOutlets
  @IBOutlet weak var stepOneBtn: UIButton!
  @IBOutlet weak var stepTwoBtn: UIButton!
  @IBOutlet weak var stepThreeBtn: UIButton!
  
  //MARK:- IBActions
  @IBAction func dismissAct(_ sender: Any){
    self.dismiss(animated: true, completion: nil)
      
  }
  //MARK:- Internal Property
  let originColor: UIColor = UIColor.init(named: "ThemeColor")!
  
  var houseModel: HouseInfoForInternal = HouseInfoForInternal()
  var stepOne: HouseInfoStepOneForInternal = HouseInfoStepOneForInternal()
  var stepTwo: HouseInfoStepTwoForInternal = HouseInfoStepTwoForInternal()
  var stepThree: HouseInfoStepThreeForInternal = HouseInfoStepThreeForInternal()
  
  var houseInfoData: [String: Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
      
      print("mainVC: ", houseInfoData)
        // Do any additional setup after loading the view.
    }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let uploadIntroVC = segue.destination as? UploadIntroViewController else {return}
    uploadIntroVC.stepOne = stepOne
    guard let roomImageVC = segue.destination as? RoomImageAddViewController else {return}
    roomImageVC.stepTwo = stepTwo
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    btnChange()
    houseModel.houseInfoStepOneForInternal = stepOne
    houseModel.houseInfoStepTwoForInternal = stepTwo
    houseModel.houseInfoStepThreeForInternal = stepThree
    
    //MARK:- test print
    print("internal city: ", stepOne.address.city)
    print("internal dong: ", stepOne.address.dong)
    print("internal houseType: ", stepOne.houseType)
    print("internal roomcount: ", stepOne.roomCount)
    print("internal amenities : ", stepOne.amenities)
    print("internal facilities : ", stepOne.facilities)
    print("internal roomName : ", stepTwo.roomName)
    print("internal roomImage : ", stepTwo.roomImageURL)
   
    
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//MARK:- extension
extension UploadFlowMainViewController {
  //MARK:- change button title & Color to done
  func changeToDoneBtn(btn: UIButton) {
    
    btn.setTitle("입력됨", for: .normal)
    btn.setTitleColor(.white, for: .normal)
    btn.backgroundColor = originColor
   
  }
  
  //MARK:- reset btn status 
  func resetContinueBtn(btn: UIButton) {
    
    btn.setTitle("계속", for: .normal)
    btn.setTitleColor(originColor, for: .normal)
    btn.backgroundColor = .white
    btn.layer.borderWidth = 1
    btn.layer.borderColor = originColor.cgColor
  }
  
  func btnChange() {
    if stepOne.address.latitude == 0.0 {
      resetContinueBtn(btn: stepOneBtn)
    }else {
      changeToDoneBtn(btn: stepOneBtn)
    }
    
    if stepTwo.roomName == "0000" {
      resetContinueBtn(btn: stepTwoBtn)
    }else {
      changeToDoneBtn(btn: stepTwoBtn)
    }
  }
}
