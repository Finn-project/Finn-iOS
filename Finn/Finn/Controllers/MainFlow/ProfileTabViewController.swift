//
//  ProfileViewController.swift
//  Finn
//
//  Created by 배지호 on 2018. 4. 2..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class ProfileTabViewController: UIViewController {
  
  //MARK:- IBOutlets
  @IBOutlet weak var profileImgView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  //Buttons
  @IBOutlet weak var profileDetailBtn: UIButton!
  @IBOutlet weak var toLoginFlowBtn: UIButton!
  @IBOutlet weak var becomeHostBtn: UIButton!
  @IBOutlet weak var settingBtn: UIButton!
  
  //MARK:- Data Properties
  var user: User!
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    //checks login status
    if User.checkCurrentUser() {
        changeProfile()
        changeButtonToLoginStatus()
    }
  }
  
}

//MARK:- Segue support
extension ProfileTabViewController {
  
  // turn Off all tabbar in nextViews
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let targetVC = segue.destination
    targetVC.hidesBottomBarWhenPushed = true
  }
}

//MARK:- helper functions
extension ProfileTabViewController {
  
  func changeProfile() {
    //get additional info userdefaults
    //redraw profiles, baseValues are place holder
  }
  
  func changeButtonToLoginStatus() {
    profileDetailBtn.isHidden = false
    toLoginFlowBtn.isEnabled = false
    
    becomeHostBtn.isEnabled = true
  }
  
  func changeButtonToLogoutStatus() {
    profileDetailBtn.isHidden = true
    toLoginFlowBtn.isEnabled = true
    
    becomeHostBtn.isEnabled = false
  }
}
