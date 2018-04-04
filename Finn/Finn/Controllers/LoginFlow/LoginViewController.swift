//
//  LoginViewController.swift
//  Finn
//
//  Created by 배지호 on 2018. 4. 2..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
  
  //MARK: IBOutlets
  @IBOutlet weak var loginEmailTF: UITextField!
  @IBOutlet weak var loginPWTF: UITextField!
  @IBOutlet weak var loginBtn: UIButton!
  
  //MARK: Internal Properties
  
  //MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //drawing textFields
    loginEmailTF.borderBottom(height: 1.0, color: UIColor.white)
    loginPWTF.borderBottom(height: 1.0, color: UIColor.white)
  }
}

//MARK:- IBActions
extension LoginViewController {
  
  //MARK: Tap Gesture Recognizer
  @IBAction func removeKeyboard(_ sender: Any) {
    loginEmailTF.resignFirstResponder()
    loginPWTF.resignFirstResponder()
  }
  
  @IBAction func doLogin() {
    self.dismiss(animated: true, completion: nil)
  }
}

//MARK:- TextField Delegate
extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if loginEmailTF.text == "" {
      loginEmailTF.becomeFirstResponder()
    } else {
      loginEmailTF.resignFirstResponder()
      loginPWTF.becomeFirstResponder()
    }
    return true
  }
}
