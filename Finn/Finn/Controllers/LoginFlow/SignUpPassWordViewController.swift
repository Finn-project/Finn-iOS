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
  
  //MARK:- IBOutlet
  @IBOutlet weak var passWordTF: UITextField!
  @IBOutlet weak var checkPassWordTF: UITextField!
  @IBOutlet weak var keyboardMargin: NSLayoutConstraint!
  
  //MARK:- Internal Properties
  var signUpData: [String: Any] = [:]
  
  
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
  
  //MARK:- IBAction
  @IBAction func signUpAction(_ sender: Any) {
    passwordData()
    dataInfo()
    
  }
  @IBAction func removeKeyboard(_ sender: Any) {
    passWordTF.resignFirstResponder()
    checkPassWordTF.resignFirstResponder()
  }
  
  //MARK: Alamofire
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
        case .success:
          if let data = response.data {
            do {
              let user = try JSONDecoder().decode(User.self, from: data)
              user.saveToUserDefaults()
              if let writtenToken = User.loadTokenFromUserDefaults() {
                print("signUp: success, writtenToken: \(writtenToken)")
              }
              self.dismiss(animated: true, completion: nil)
            } catch (let error) {
              print("signUp: decode failed, \(error.localizedDescription)")
            }
          }
        case .failure(let error):
          print("signUp: auth failed, \(error.localizedDescription)")
        }
    }
  }
  
  //MARK: Data Receive
  private func passwordData() {
    guard let passWord = passWordTF.text,
      passWord.count >= 8 else { return passWordTF.shake() }
    signUpData.updateValue(passWordTF.text!, forKey: "password")
    guard let checkPassWord = checkPassWordTF.text,
      passWordTF.text == checkPassWord
      else { return checkPassWordTF.shake() }
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
  
  //MARK: text Count limit
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let text = textField.text ?? ""
    let replacedText = (text as NSString).replacingCharacters(in: range, with: string)
    let _ = [NSAttributedStringKey.font: textField.font!]
    guard replacedText.count < 20 else { return false }
    return true
  }
}
