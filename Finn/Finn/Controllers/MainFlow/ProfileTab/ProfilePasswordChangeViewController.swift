//
//  ProfilePasswordChangeViewController.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 12..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import Alamofire

class ProfilePasswordChangeViewController: UIViewController {
  
  //MARK:- IBOutlets
  @IBOutlet weak var viewTitleLbl: UILabel!
  
  @IBOutlet weak var currentPWLbl: UILabel!
  @IBOutlet weak var currentPWLblCenter: NSLayoutConstraint!
  @IBOutlet weak var currentPWTf: UITextField!
  
  @IBOutlet weak var newPWLbl: UILabel!
  @IBOutlet weak var newPWTf: UITextField!
  @IBOutlet weak var confirmPWLbl: UILabel!
  @IBOutlet weak var confirmPWTf: UITextField!
  
  let themeColor = UIColor(named: "ThemeColor")!
  
  //MARK:- internal data
  var userProfile: UserProfile!
  
  var isConfirmed: Bool = false {
    didSet {
      if isConfirmed {
        drawConfirmedState()
      }
    }
  }
  
  var isDone: Bool = false {
    didSet {
      if isDone {
        print("password changed successfully")
        self.navigationController?.popViewController(animated: true)
      }
    }
  }
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    drawInitialState()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
}

//MARK:- Button Selectors
extension ProfilePasswordChangeViewController {
  
  @IBAction func wallClicked(_ sender: UITapGestureRecognizer) {
    currentPWTf.resignFirstResponder()
    newPWTf.resignFirstResponder()
    confirmPWTf.resignFirstResponder()
  }
  
  @objc func checkCurrentPassword() {
    
    guard let password = currentPWTf.text,
      password != "",
      password.count >= 8 else {
        currentPWTf.shake()
        return
    }
    doPsudoLogin(password: password)
  }
  
  @objc func changePassword() {
    
    guard let password = newPWTf.text,
      password != "",
      password.count >= 8 else {
        newPWTf.shake()
        return
    }
    
    guard let confirmPassword = confirmPWTf.text,
      confirmPassword == password else {
        confirmPWTf.shake()
        return
    }
    
    doChangePassword(newPw: password, confirmPw: confirmPassword)
  }
}

//MARK:- networking support
extension ProfilePasswordChangeViewController {
  func doPsudoLogin(password: String){
    
    var parameters: [String: String] = [:]
    parameters.updateValue(userProfile.email, forKey: "username")
    parameters.updateValue(password, forKey: "password")
    
    Alamofire
      .request(Network.Auth.loginURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
      .validate()
      .responseJSON { (response) in
        switch response.result {
        case .success:
          if let data = response.data {
//            , let text = String(data: data, encoding: .utf8) {
//            print(text)
            do {
              let user = try JSONDecoder().decode(User.self, from: data)
              user.saveToUserDefaults()
              
              if let writtenToken = User.loadTokenFromUserDefaults() {
                print("passwordChangeLogin: success, writtenToken: \(writtenToken)")
              }
              
              self.isConfirmed = true
              
            } catch (let error) {
              print("passwordChangeLogin: decode failed, \(error.localizedDescription)")
            }
          }
        case .failure(let error):
          print("passwordChangeLogin: auth failed, \(error.localizedDescription)")
          self.currentPWTf.shake()
      }
    }
    
  }
  
  func doChangePassword(newPw: String, confirmPw: String) {
    
    // password not changing, checked from postman at 1847
    
    var headers: HTTPHeaders = [:]
    headers.updateValue("token " + User.loadTokenFromUserDefaults(), forKey: "Authorization")
    
    var parameters:[String: String] = [:]
    parameters.updateValue(newPw, forKey: "password")
    parameters.updateValue(confirmPw, forKey: "confirm_password")
    
    Alamofire
      .request(Network.Auth.signUpURL + "\(userProfile.pk)/", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
      .validate()
      .responseJSON { (response) in
        switch response.result {
        case .success:
          if let data = response.data {
//            , let text = String(data: data, encoding: .utf8) {
//            print(text)
            do {
              let _ = try JSONDecoder().decode(UserInfo.self, from: data)
              self.isDone = true
            } catch (let error) {
              print("changePW: decode failed, \(error.localizedDescription)")
            }
          }
        case .failure(let error):
          print("changePW: auth failed, \(error.localizedDescription)")
      }
    }
    
  }
  
}


//MARK:- state change functions
extension ProfilePasswordChangeViewController {
  func drawInitialState() {
    currentPWLblCenter.constant = -92
    
    viewTitleLbl.text = "현재 비밀번호 확인"
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인하기", style: .plain,
                                                             target: self, action: #selector(self.checkCurrentPassword))
    
    //prepare animation initial frame
    newPWLbl.center.x += view.bounds.width
    newPWTf.center.x += view.bounds.width
    confirmPWLbl.center.x += view.bounds.width
    confirmPWTf.center.x += view.bounds.width
    
    currentPWTf.drawBottomBorder(backColor: .white, withColor: themeColor)
    newPWTf.drawBottomBorder(backColor: .white, withColor: themeColor)
    confirmPWTf.drawBottomBorder(backColor: .white, withColor: themeColor)
  }
  
  func drawConfirmedState() {

    viewTitleLbl.text = "비밀번호 변경하기"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "변경하기", style: .done,
                                                             target: self, action: #selector(self.changePassword))
    
    newPWLbl.isHidden = false
    newPWTf.isHidden = false
    confirmPWLbl.isHidden = false
    confirmPWTf.isHidden = false
    
    //animate here
    UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
      self.currentPWLbl.center.y -= 100
      self.currentPWTf.center.y -= 100
      
      self.newPWLbl.center.x -= self.view.bounds.width
      self.newPWTf.center.x -= self.view.bounds.width
      self.confirmPWLbl.center.x -= self.view.bounds.width
      self.confirmPWTf.center.x -= self.view.bounds.width
      
      self.currentPWTf.layer.shadowColor = UIColor.lightGray.cgColor
    }, completion: nil)

    self.currentPWLblCenter.constant = -192
    
    currentPWLbl.textColor = .lightGray
    currentPWTf.textColor = .lightGray
    currentPWTf.layer.shadowColor = UIColor.lightGray.cgColor
    
    currentPWTf.isUserInteractionEnabled = false
  }
}
