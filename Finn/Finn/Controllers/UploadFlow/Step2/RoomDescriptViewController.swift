//
//  RoomDescriptViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class RoomDescriptViewController: UIViewController {
 
  //MARK:- Internal Property
  var stepTwo: HouseInfoStepTwoForInternal = HouseInfoStepTwoForInternal()

  //MARK:- IBOutlets
  @IBOutlet weak var roomNameTf: UITextField!
  @IBOutlet weak var roomDescriptTf: UITextField!
  
  @IBAction func tappedView(_ sender: UITapGestureRecognizer) {
    roomNameTf.resignFirstResponder()
    roomDescriptTf.resignFirstResponder()
  }
  //MARK: GO TO UploadIntro
  @IBAction func backToIntro(_ sender: Any){
    
    if let rootVC = self.navigationController?.viewControllers[0] as? UploadFlowMainViewController {
      stepTwoForUpload()
      
      rootVC.stepTwo = self.stepTwo
    }
    
    self.navigationController?.popToRootViewController(animated: true)
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
    // Do any additional setup after loading the view.
      print(stepTwo.roomImageURL)
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
//MARK:- extension
extension RoomDescriptViewController {
  func stepTwoForUpload() {
    guard let roomName = roomNameTf.text else {return}
    stepTwo.roomName = roomName
    guard let roomDescript = roomDescriptTf.text else {return}
    stepTwo.roomDescript = roomDescript
  }
}
extension RoomDescriptViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if roomNameTf.text != "" {
      roomNameTf.resignFirstResponder()
      roomDescriptTf.becomeFirstResponder()
    }else {
      roomDescriptTf.resignFirstResponder()
    }
    return true
    
  }
}


