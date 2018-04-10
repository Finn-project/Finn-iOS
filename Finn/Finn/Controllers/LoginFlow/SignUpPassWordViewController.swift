//
//  SignUpPassWordViewController.swift
//  Finn
//
//  Created by 배지호 on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import Alamofire

class SignUpPassWordViewController: UIViewController {
  
  //MARK
  @IBOutlet weak var passWordTF: UITextField!
  @IBOutlet weak var checkPassWordTF: UITextField!
  @IBOutlet weak var keyboardMargin: NSLayoutConstraint!
  
  var signUpData: [String: Any] = [:]
  @IBAction func signUpAction(_ sender: Any) {
    passwordData()
    dataInfo()
    self.dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    addKeyboardObserver()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    passWordTF.borderBottom(height: 1.0, color: .white)
    checkPassWordTF.borderBottom(height: 1.0, color: .white)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
}

extension SignUpPassWordViewController {
  
  @IBAction func removeKeyboard(_ sender: Any) {
    passWordTF.resignFirstResponder()
    checkPassWordTF.resignFirstResponder()
  }
  
  private func dataInfo() {
    let params: Parameters = [
      "username" : signUpData["username"]!,
      "password" : signUpData["password"]!,
      "confirm_password" : signUpData["confirm_password"]!,
      "first_name" : signUpData["first_name"]!,
      "last_name" : signUpData["last_name"]!,
      "phone_num" : signUpData["phone_num"]!
    ]
    print("params:\(params)")
    Alamofire
      .request(Network.Auth.signUpURL, method: .post, parameters: params)
      .validate()
      .responseData { (response) in
        switch response.result {
        case .success(let value):
          print("value: \(value)")
        case.failure(let error):
          print("error: \(error)")
        }
    }
  }
  
  private func passwordData() {
    guard let _ = passWordTF.text else { return print("passwordTF: nil") }
    signUpData.updateValue(passWordTF.text!, forKey: "password")
    guard let _ = checkPassWordTF.text else { return print("checkPassWordTF: nil") }
    signUpData.updateValue(checkPassWordTF.text!, forKey: "confirm_password")
  }
  //MARK: keyboardNotification
  private func addKeyboardObserver() {
    NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: .main) {
      [weak self] in
      guard let userInfo = $0.userInfo,
        let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt
        else { return }
      
      UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: curve), animations: {
        self?.keyboardMargin.constant = keyboardFrame.height + 20
        self?.view.layoutIfNeeded()
      })
    }
    
    NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: .main) {
      [weak self] in
      guard let userInfo = $0.userInfo,
        let _ = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt
        else { return }
      
      UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: curve), animations: {
        self?.keyboardMargin.constant = 10
        self?.view.layoutIfNeeded()
      })
    }
  }
}

extension SignUpPassWordViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if passWordTF.text == "" {
      passWordTF.becomeFirstResponder()
    } else {
      passWordTF.resignFirstResponder()
      checkPassWordTF.becomeFirstResponder()
    }
    return true
  }
}
