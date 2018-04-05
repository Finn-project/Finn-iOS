//
//  SignUpViewController.swift
//  Finn
//
//  Created by 배지호 on 2018. 4. 2..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class SignUpNameViewController: UIViewController {
  
  var signUpData: [String: Any] = [:]
  
  @IBOutlet weak var firstNameTF: UITextField!
  @IBOutlet weak var lastNameTF: UITextField!
  @IBOutlet weak var keyboardMargin: NSLayoutConstraint!
  @IBOutlet weak var nextBtn: UIButton!
  
  //MARK: - Gesture
  @IBAction func removeKeyboard(_ sender: Any) {
    firstNameTF.resignFirstResponder()
    lastNameTF.resignFirstResponder()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.updateFocusIfNeeded()
    firstNameTF.borderBottom(height: 1.0, color: UIColor.white)
    lastNameTF.borderBottom(height: 1.0, color: UIColor.white)
    addKeyboardObserver()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let emailVC = segue.destination as? SignUpEmailPhoneViewController else {return }
    nameData()
    emailVC.signUpData = signUpData
  }
}


//MARK: UITextField borderBottom
extension UITextField {
  func borderBottom(height: CGFloat, color: UIColor) {
    let border = CALayer()
    border.frame = CGRect(x: 0, y: self.frame.height-height, width: self.frame.width, height: height)
    border.backgroundColor = color.cgColor
    self.layer.addSublayer(border)
  }
}

//MARK: - extension: UIButton
extension UIButton {
  func btnCustom() {
    let btn = CALayer()
    btn.cornerRadius = self.frame.width / 2
    btn.borderWidth = 2
    btn.borderColor = UIColor.black.cgColor
    btn.backgroundColor = UIColor.white.cgColor
    self.layer.addSublayer(btn)
  }
}

//MARK: - extension: SignUpViewController

extension SignUpNameViewController {
  
  //MARK: text update data
  private func nameData() {
    guard let firstName = firstNameTF.text else { return print("firstName: nil") }
    signUpData.updateValue(firstNameTF.text, forKey: "first_name")
    guard let lastName = lastNameTF.text else { return print("lastName: nil") }
    signUpData.updateValue(lastNameTF.text, forKey: "last_name")
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

extension SignUpNameViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if firstNameTF.text == "" {
      firstNameTF.becomeFirstResponder()
    } else {
      firstNameTF.resignFirstResponder()
      lastNameTF.becomeFirstResponder()
    }
    return true
  }
}
