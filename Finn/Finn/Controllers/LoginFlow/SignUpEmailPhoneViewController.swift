//
//  SignUpEmailViewController.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class SignUpEmailPhoneViewController: UIViewController {
  
  //MARK:- Property
  var signUpData: [String: Any] = [:]
  
  //MARK:- IBOutlet
  @IBOutlet weak var emailTF: UITextField!
  @IBOutlet weak var phoneNumTF: UITextField!
  @IBOutlet weak var emailTitle: UILabel!
  @IBOutlet weak var keyboardMargin: NSLayoutConstraint!
  //MARK:- IBAction
  //MARK: Gesture
  @IBAction func removeKeyboard(_ sender: Any) {
    emailTF.resignFirstResponder()
    phoneNumTF.resignFirstResponder()
  }
  //MARK:- LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    emailTF.borderBottom(height: 1.0, color: UIColor.white)
    phoneNumTF.borderBottom(height: 1.0, color: UIColor.white)
    addKeyboardObserver()
  }
  //MARK:- removeObserver
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  //MARK:- prepare
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let passwordVC = segue.destination as? SignUpPassWordViewController else {return }
    emailPhoneData()
    print(signUpData)
    passwordVC.signUpData = signUpData
  }
}

//MARK:- extension
extension SignUpEmailPhoneViewController {
  //MARK: text updateValue method
  private func emailPhoneData() {
    guard let email = emailTF.text, email != "", email.contains("@") == true else { return print("emailTF: nil") }
    signUpData.updateValue(emailTF.text!, forKey: "email")
    guard let phone = phoneNumTF.text, phone != "", phone.contains("@") == true else { return print("phoneNumTF: nil") }
    signUpData.updateValue(phoneNumTF.text!, forKey: "phone_num")
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
        let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
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
//MARK: - extension: SignUpEmailPasswordViewController
extension SignUpEmailPhoneViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if emailTF.text == "" {
      emailTF.becomeFirstResponder()
    } else {
      emailTF.resignFirstResponder()
      phoneNumTF.becomeFirstResponder()
    }
    return true
  }
}
