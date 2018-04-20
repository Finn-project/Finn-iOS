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
  var houseInfoData: [String: Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
      
      print("mainVC: ", houseInfoData)
        // Do any additional setup after loading the view.
    }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let uploadIntroVC = segue.destination as? UploadIntroViewController else {return}
    uploadIntroVC.houseInfoData = houseInfoData
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    btnChange()
    houseModel.houseInfoStepOneForInternal = stepOne
//    houseModel.houseInfoStepTwoForInternal = stepTwo
    print("city: ", stepOne.address.city)
    print("dong: ", stepOne.address.dong)
    print("houseType: ", stepOne.houseType)
    print("amenities : ", stepOne.amenities)
    print("facilities : ", stepOne.facilities)
    
   
    
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
  }
}
