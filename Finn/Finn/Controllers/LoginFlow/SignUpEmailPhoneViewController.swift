//
//  SignUpEmailViewController.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class SignUpEmailPhoneViewController: UIViewController {
  
  
  //MARK:- IBOutlet
  @IBOutlet weak var emailTF: UITextField!
  @IBOutlet weak var phoneNumTF: UITextField!
  @IBOutlet weak var emailTitle: UILabel!
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
    phoneNumTF.borderBottom(height: 1.0, color: UIColor.white)
  }
  
  //MARK:- removeObserver
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  //MARK:- segue supports
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let passwordVC = segue.destination as? SignUpPassWordViewController else {return }
    emailPhoneData()
    print(signUpData)
    passwordVC.signUpData = signUpData
  }
}

extension SignUpEmailPhoneViewController {
  //MARK:- IBAction
  @IBAction func removeKeyboard(_ sender: Any) {
    emailTF.resignFirstResponder()
    phoneNumTF.resignFirstResponder()
  }
  //MARK: Data Receive
  private func emailPhoneData() {
    guard let email = emailTF.text,
      email != "",
      email.contains("@") == true,
      email.contains(".") == true
      else { return emailTF.shake() }
    signUpData.updateValue(emailTF.text!, forKey: "username")
    guard let phoneNum = phoneNumTF.text,
      phoneNum != ""
      else { return phoneNumTF.shake() }
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
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let text = textField.text ?? ""
    let replacedText = (text as NSString).replacingCharacters(in: range, with: string)
    let _ = [NSAttributedStringKey.font: textField.font!]
    guard replacedText.count < 30 else { return false }
    return true
  }
}

