//
//  ProfileDetailViewController.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 3..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import Alamofire

class ProfileDetailViewController: UIViewController {
  
  //MARK:- data property
  var userProfile: UserProfile!

  //MARK:- IBOutlets
  @IBOutlet weak var lastNameLabel: UILabel!
  @IBOutlet weak var firstNameLabel: UILabel!
  @IBOutlet weak var lastNameTf: UITextField!
  @IBOutlet weak var firstNameTf: UITextField!
  @IBOutlet weak var userNameTf: UITextField!
  @IBOutlet weak var phoneNumTf: UITextField!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var changePWBtn: UIButton!
  @IBOutlet weak var changeProfileImg: UIButton!
  
  let themeColor = UIColor(named: "ThemeColor")!
  
//  @IBOutlet weak var changeInfoBtn: UIBarButtonItem!
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    drawInitialState()
  }
  
  //MARK: - drawing textFields
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
}

//MARK:- IBActions and Selectors
extension ProfileDetailViewController {
  @IBAction func rewindFromEditView(_ sender: UIStoryboardSegue) {
  }
  
  @IBAction func wallClicked(_ sender: UITapGestureRecognizer) {
    lastNameTf.resignFirstResponder()
    firstNameTf.resignFirstResponder()
    userNameTf.resignFirstResponder()
    phoneNumTf.resignFirstResponder()
  }
  
  @objc func awakeToEdit() {
    drawEditMode()
  }
  
  @objc func doneEdit() {
    //needs networking
    
    drawInitialState()
  }
}

//MARK:- drawing function
extension ProfileDetailViewController {
  func drawInitialState() {
    guard let profile = self.userProfile else {return}
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정하기", style: .plain,
                                                             target: self, action: #selector(self.awakeToEdit))
    
    lastNameTf.text = profile.lastName
    firstNameTf.text = profile.firstName
    userNameTf.text = profile.userName
    phoneNumTf.text = profile.phoneNumber
    
    firstNameLabel.isHidden = true
    lastNameLabel.isHidden = true
    
    firstNameTf.isUserInteractionEnabled = false
    lastNameTf.isUserInteractionEnabled = false
    userNameTf.isUserInteractionEnabled = false
    phoneNumTf.isUserInteractionEnabled = false
    
    userNameTf.drawBottomBorder(backColor: .white, withColor: .lightGray)
    phoneNumTf.drawBottomBorder(backColor: .white, withColor: .lightGray)
    firstNameTf.drawBottomBorder(backColor: .white, withColor: .white)
    lastNameTf.drawBottomBorder(backColor: .white, withColor: .white)
  
    changePWBtn.center.x -= 120
    
    UIView.animate(withDuration: 0.33) {
      self.lastNameTf.center.x += 40
      self.changePWBtn.center.x += 120
    }
    changeProfileImg.center.x -= 120
    lastNameTf.center.x -= 40
    lastNameTf.textAlignment = .right
    
    changePWBtn.isHidden = false
    changeProfileImg.isHidden = true
  }
  
  func drawEditMode() {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정완료", style: .done,
                                                             target: self, action: #selector(self.doneEdit))
    
    self.firstNameLabel.isHidden = false
    self.lastNameLabel.isHidden = false
    
    firstNameTf.isUserInteractionEnabled = true
    lastNameTf.isUserInteractionEnabled = true
    userNameTf.isUserInteractionEnabled = true
    phoneNumTf.isUserInteractionEnabled = true
    
    userNameTf.drawBottomBorder(backColor: .white, withColor: themeColor)
    phoneNumTf.drawBottomBorder(backColor: .white, withColor: themeColor)
    firstNameTf.drawBottomBorder(backColor: .white, withColor: themeColor)
    lastNameTf.drawBottomBorder(backColor: .white, withColor: themeColor)
    
    UIView.animate(withDuration: 0.33) {
      self.lastNameTf.center.x -= 40
      self.changeProfileImg.center.x -= 120
    }
    self.changeProfileImg.center.x += 120
    lastNameTf.center.x += 40
    lastNameTf.textAlignment = .natural
    
    changePWBtn.isHidden = true
    changeProfileImg.isHidden = false
  }
}

