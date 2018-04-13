//
//  SignUpEmailViewController.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import Alamofire

class SignUpEmailPhoneViewController: UIViewController {
  
  
  //MARK:- IBOutlet
  @IBOutlet weak var emailTF: UITextField!
  @IBOutlet weak var passWordTF: UITextField!
  @IBOutlet weak var checkPassWordTF: UITextField!
  @IBOutlet weak var emailTitle: UILabel!
  @IBOutlet weak var passWordSubTitle: UILabel!
  @IBOutlet weak var passWordTitle: UILabel!
  @IBOutlet weak var keyboardMargin: NSLayoutConstraint!
  //MARK:- Internal Properties
  var signUpData: [String: Any] = [:]
  
  //MARK:- LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    addKeyboardObserver()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    emailTF.borderBottom(height: 1.0, color: UIColor.white)
    passWordTF.borderBottom(height: 1.0, color: UIColor.white)
    checkPassWordTF.borderBottom(height: 1.0, color: UIColor.white)
  }
  
  //MARK:- removeObserver
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
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
          if response.response?.statusCode == 400 {
            self.passWordTF.shake()
            self.checkPassWordTF.shake()
          } else if response.response?.statusCode == 409 {
            self.emailTF.shake()
          }
          print("signUp: auth failed, \(error.localizedDescription)")
        }
    }
  }
}

extension SignUpEmailPhoneViewController {
  
  //MARK:- IBAction
  @IBAction func removeKeyboard(_ sender: Any) {
    emailTF.resignFirstResponder()
    passWordTF.resignFirstResponder()
    checkPassWordTF.resignFirstResponder()
  }
  
  @IBAction func signUpAction(_ sender: Any) {
    emailPassWordData()
    dataInfo()
  }
  
  //MARK: Data Receive
  private func emailPassWordData() {
    guard let email = emailTF.text,
      email != "",
      email.contains("@") == true,
      email.contains(".") == true
      else { return emailTF.shake() }
    signUpData.updateValue(emailTF.text!, forKey: "username")
    guard let passWord = passWordTF.text,
      passWord.count >= 8
      else { return passWordTF.shake() }
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
        self?.keyboardMargin.constant = keyboardFrame.height + 5
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
        self?.keyboardMargin.constant = 5
        self?.view.layoutIfNeeded()
      })
    }
  }
}

extension SignUpEmailPhoneViewController: UITextFieldDelegate {
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    if textField.tag == 4 {
      UIView.animate(withDuration: 3.0, delay: 0, options: [.repeat], animations: {
        self.emailTitle.isHidden = false
        self.passWordTitle.isHidden = true
        self.passWordSubTitle.isHidden = true
      })
    } else if textField.tag == 5 {
      UIView.animate(withDuration: 3.0, delay: 0, options: [.repeat], animations: {
        self.emailTitle.isHidden = true
        self.passWordTitle.isHidden = false
        self.passWordSubTitle.isHidden = false
      })
    } else if textField.tag == 6 {
      UIView.animate(withDuration: 3.0, delay: 0, options: [.repeat], animations: {
        self.emailTitle.isHidden = true
        self.passWordTitle.isHidden = false
        self.passWordSubTitle.isHidden = false
      })
    }
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField.tag == 4 {
      emailTF.becomeFirstResponder()
      if emailTF.text != "" {
        emailTF.resignFirstResponder()
        passWordTF.becomeFirstResponder()
      }
    } else if textField.tag == 5 {
      if passWordTF.text != "" {
        passWordTF.resignFirstResponder()
        checkPassWordTF.becomeFirstResponder()
      }
    } else {
      checkPassWordTF.resignFirstResponder()
    }
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let text = textField.text ?? ""
    let replacedText = (text as NSString).replacingCharacters(in: range, with: string)
    let _ = [NSAttributedStringKey.font: textField.font!]
    guard replacedText.count < 30 else { return false }
    return true
  }
}

