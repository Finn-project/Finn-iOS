//
//  UploadFlowMainViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 3..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import Alamofire

class UploadFlowMainViewController: UIViewController {
  
  //MARK:- IBOutlets
  @IBOutlet weak var stepOneBtn: UIButton!
  @IBOutlet weak var stepTwoBtn: UIButton!
  @IBOutlet weak var stepThreeBtn: UIButton!
  @IBOutlet weak var saveBtn: UIButton!
  //MARK:- IBActions
  //MARK: dissmissAction
  @IBAction func dismissAct(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
      
  }
  //MARK: upload to Server
  @IBAction func saveToServer(_ sender: Any) {
    
      var requestHeader: HTTPHeaders = [:]
      requestHeader.updateValue("Token " + User.loadTokenFromUserDefaults()!, forKey: "Authorization")
      
      //MARK:- parameters
//      let params: [String: Any] = ["house_type": "HO", "name": stepTwo.roomName,
//                                   "description": stepTwo.roomDescript, "room": stepOne.roomCount,
//                                   "bed": stepOne.bedCount, "bathroom": stepOne.bathroomCount,
//                                   "personnel": stepOne.peopleCount, "amenities": stepOne.amenities,
//                                   "facilities": stepOne.facilities,
//                                   "minimum_check_in_duration": stepThree.minimumCheckDays,
//                                   "maximum_check_in_duration": stepThree.maximumCheckDays,
//                                   "maximum_check_in_range": stepThree.totalCheckDays,
//                                   "price_per_night": stepThree.price, "country": stepOne.country,
//                                   "city": stepOne.address.city, "district": stepOne.address.district,
//                                   "dong": stepOne.address.dong, "address1": stepOne.address.firstDetailAddress,
//                                   "latitude": stepOne.address.latitude, "longitude": stepOne.address.longitude,
//                                   "disable_days": stepThree.disableDays,
//                                   "reserve_days": [], "img_cover": "",
//                                   "house_images": []]
    let params: [String: Any] = ["house_type": "HO", "name": "최현호집",
                                 "description": "되는것이냐", "room": 1,
                                 "bed": 2, "bathroom": 3,
                                 "personnel": 2, "amenities": [1, 2],
                                 "facilities": [2, 3],
                                 "minimum_check_in_duration": 1,
                                 "maximum_check_in_duration": 2,
                                 "maximum_check_in_range": 90,
                                 "price_per_night": 123, "country": "seoul",
                                 "latitude": 36.333, "longitude": 127.333,
                                 "disable_days": "2018-04-27"
                                 ]
    
      print(params)
      print(requestHeader)
    //response code 400 찍힘 현재
    //MARK:- Alamofire post 
      Alamofire
        .request(Network.House.getHouseURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: requestHeader)
        .validate()
        .responseData { (response) in
          switch response.result {
          case .success:
            print("success")
            self.dismiss(animated: true, completion: nil)
          case .failure(let error):
            print("post failed : \(error.localizedDescription)")
            self.dismiss(animated: true, completion: nil)
          }
      }
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
  //MARK:- prepare
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let uploadIntroVC = segue.destination as? UploadIntroViewController else {return}
    uploadIntroVC.stepOne = stepOne
    guard let roomImageVC = segue.destination as? RoomImageAddViewController else {return}
    roomImageVC.stepTwo = stepTwo
  }
  //MARK:- viewWillAppear
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
    if stepThree.price == 0 {
      resetContinueBtn(btn: stepThreeBtn)
      saveBtn.isHidden = true
    }else {
      changeToDoneBtn(btn: stepThreeBtn)
      saveBtn.isHidden = false
    }
  }
  
}
