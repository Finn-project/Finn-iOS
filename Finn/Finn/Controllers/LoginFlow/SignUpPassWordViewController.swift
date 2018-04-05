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
  
  var signUpData: [String: Any] = [:]
  
  @IBOutlet weak var passWordTF: UITextField!
  @IBOutlet weak var checkPassWordTF: UITextField!
  @IBOutlet weak var keyboardMargin: NSLayoutConstraint!
  
  @IBAction func removeKeyboard(_ sender: Any) {
    passWordTF.resignFirstResponder()
    checkPassWordTF.resignFirstResponder()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    passWordTF.borderBottom(height: 1.0, color: .white)
    checkPassWordTF.borderBottom(height: 1.0, color: .white)
    addKeyboardObserver()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
}

extension SignUpPassWordViewController {
  
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
