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
 
  //MARK:- IBActions
  @IBAction func dismissAct(_ sender: Any){
    self.dismiss(animated: true, completion: nil)
      
  }
  //MARK:- Internal Property
  let originColor: UIColor = UIColor.init(named: "ThemeColor")!
  
  var houseModel: HouseInfoForInternal = HouseInfoForInternal()
  var stepOne: HouseInfoStepOneForInternal = HouseInfoStepOneForInternal()
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
  func changeToDoneBtn() {
    
    stepOneBtn.setTitle("입력됨", for: .normal)
    stepOneBtn.setTitleColor(.white, for: .normal)
    stepOneBtn.backgroundColor = originColor
   
  }
  
  //MARK:- reset btn status 
  func resetContinueBtn() {
    
    stepOneBtn.setTitle("계속", for: .normal)
    stepOneBtn.setTitleColor(originColor, for: .normal)
    stepOneBtn.backgroundColor = .white
    stepOneBtn.layer.borderWidth = 1
    stepOneBtn.layer.borderColor = originColor.cgColor
  }
  
  func btnChange() {
    if stepOne.address.latitude == 0.0 {
      resetContinueBtn()
    }else {
      changeToDoneBtn()
    }
  }
}
