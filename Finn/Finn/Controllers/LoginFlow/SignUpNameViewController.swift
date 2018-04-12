//
//  SignUpViewController.swift
//  Finn
//
//  Created by 배지호 on 2018. 4. 2..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class SignUpNameViewController: UIViewController {
  
  //MARK:- IBOutlets
  @IBOutlet weak var firstNameTF: UITextField!
  @IBOutlet weak var lastNameTF: UITextField!
  @IBOutlet weak var phoneNumTF: UITextField!
  @IBOutlet weak var nameTitle: UILabel!
  @IBOutlet weak var phoneNumberTitle: UILabel!
  @IBOutlet weak var keyboardMargin: NSLayoutConstraint!
  @IBOutlet weak var nextBtn: UIButton!
  
  
  //MARK:- Internal Properties
  var signUpData: [String: Any] = [:]
  
  //MARK:- LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.updateFocusIfNeeded()
    
    addKeyboardObserver()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    firstNameTF.borderBottom(height: 1.0, color: UIColor.white)
    lastNameTF.borderBottom(height: 1.0, color: UIColor.white)
    phoneNumTF.borderBottom(height: 1.0, color: UIColor.white)
  }
  
  //MARK:- removeObserver
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  //MARK:- segue supports
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let emailVC = segue.destination as? SignUpEmailPhoneViewController else {return }
    nameData()
    emailVC.signUpData = signUpData
  }
}

extension SignUpNameViewController {
  
  //MARK: IBAction
  @IBAction func removeKeyboard(_ sender: Any) {
    firstNameTF.resignFirstResponder()
    lastNameTF.resignFirstResponder()
    phoneNumTF.resignFirstResponder()
  }
  
  
  //MARK: Data Receive
  private func nameData() {
    guard let firstName = firstNameTF.text, firstName != "" else { return firstNameTF.shake()}
    signUpData.updateValue(firstNameTF.text!, forKey: "first_name")
    guard let lastName = lastNameTF.text, lastName != "" else { return lastNameTF.shake()}
    signUpData.updateValue(lastNameTF.text!, forKey: "last_name")
    guard let phoneNum = phoneNumTF.text, phoneNum != "" else { return phoneNumTF.shake() }
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
//MARK:- UITextFieldDelegate
extension SignUpNameViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if firstNameTF.text == "" {
      firstNameTF.becomeFirstResponder()
    } else if (firstNameTF.text != "") && (lastNameTF.text == "") {
      firstNameTF.resignFirstResponder()
      lastNameTF.becomeFirstResponder()
    } else {
      firstNameTF.resignFirstResponder()
      lastNameTF.resignFirstResponder()
      phoneNumTF.becomeFirstResponder()
      if phoneNumTF.becomeFirstResponder() {
        nameTitle.isHidden = true
        phoneNumberTitle.isHidden = false
      } else {
        nameTitle.isHidden = false
        phoneNumberTitle.isHidden = true
      }
    }
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let text = textField.text ?? ""
    let replacedText = (text as NSString).replacingCharacters(in: range, with: string)
    let _ = [NSAttributedStringKey.font: textField.font!]
    guard replacedText.count < 12 else { return false }
    return true
  }
}
