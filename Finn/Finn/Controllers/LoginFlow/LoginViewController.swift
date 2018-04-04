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
  @IBOutlet weak var keyboardMargin: NSLayoutConstraint!
  
  //MARK: Internal Properties
  
  //MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //drawing textFields
    loginEmailTF.borderBottom(height: 1.0, color: UIColor.white)
    loginPWTF.borderBottom(height: 1.0, color: UIColor.white)
    
    addKeyboardObserver()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
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
    guard let email = loginEmailTF.text else {
      //perform shaking animation here
      return
    }
    
    guard let password = loginPWTF.text else {
      //perform shaking animation here
      return
    }
    
    //prepare parameters
    var parameters: [String: String] = [:]
    parameters.updateValue(email, forKey: "username")
    parameters.updateValue(password, forKey: "password")
    
    // start Networking
    Alamofire
      .request(loginURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
      .responseJSON { (response) in
        switch response.result {
        case .success:
          if let data = response.data, let text = String(data: data, encoding: .utf8) {
            print(text)
            do {
              let user = try JSONDecoder().decode(User.self, from: data)
              user.saveToUserDefaults()
              
              //please!!
              if let writtenToken = User.loadTokenFromUserDefaults() {
                print("login: success, writtenToken: \(writtenToken)")
              }
              
              self.dismiss(animated: true, completion: nil)
              
            } catch (let error) {
              print("login: decode failed, \(error.localizedDescription)")
            }
          }
        case .failure(let error):
          print("login: post failed, \(error.localizedDescription)")
        }
    }
  }
  
  
}

//MARK:- animation with keyboard
extension LoginViewController {
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
        self?.keyboardMargin.constant = 30
        self?.view.layoutIfNeeded()
      })
    }
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
