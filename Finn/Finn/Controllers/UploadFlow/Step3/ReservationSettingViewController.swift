//
//  ReservationSettingViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class ReservationSettingViewController: UIViewController {
  
  var list: [String] = []
  var stepThree: HouseInfoStepThreeForInternal = HouseInfoStepThreeForInternal()
  @IBOutlet weak var setPriceTf:UITextField!
  @IBOutlet weak var minimumCheckTF: UITextField!
  @IBOutlet weak var maximumCheckTF: UITextField!
  
  @IBAction func removeKeyboard(_ sender: Any) {
    maximumCheckTF.resignFirstResponder()
    minimumCheckTF.resignFirstResponder()
    setPriceTf.resignFirstResponder()
  }
  @IBAction func backToIntro(_ sender: Any) {
    if let rootViewController = self.navigationController?.viewControllers[0] as? UploadFlowMainViewController {
      upLoadData()
      rootViewController.stepThree = self.stepThree
    }
    self.navigationController?.popToRootViewController(animated: true)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    setPriceTf.drawBottomBorder(backColor: .white, withColor: .lightGray)
    minimumCheckTF.drawBottomBorder(backColor: .white, withColor: .lightGray)
    maximumCheckTF.drawBottomBorder(backColor: .white, withColor: .lightGray)
    stepThree.disableDays = self.list
  }
}

//MARK:- extension
extension ReservationSettingViewController {
  //MARK: upLoadData
  func upLoadData() {
    guard let minimum: Int = Int(minimumCheckTF.text!) else { return }
    stepThree.minimumCheckDays = minimum
    guard let maximum: Int = Int(maximumCheckTF.text!) else { return }
    stepThree.maximumCheckDays = maximum
    guard let price: Int = Int(setPriceTf.text!) else { return }
    stepThree.price = price
  }
}
