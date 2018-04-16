//
//  UploadFlowMainViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 3..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class UploadFlowMainViewController: UIViewController {
  var houseModel: HouseInfoForInternal = HouseInfoForInternal()
  
  var stepOne: HouseInfoStepOneForInternal = HouseInfoStepOneForInternal()
  
  
  @IBAction func dismissAct(_ sender: Any){
    self.dismiss(animated: true, completion: nil)
      
  }
  //MARK:- Internal Property
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
