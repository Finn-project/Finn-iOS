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
  
  //MARK:- Data Property
  var userProfile: UserProfile?
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if User.checkCurrentUser() {
      userProfile = User.getUserProfileFromUserDefaults()
      changeProfileToLoginState()
      changeButtonToLoginState()
    } else {
      self.userProfile = nil
      changeProfileToLogoutState()
      changeButtonToLogoutState()
    }
  }
  
}

//MARK:- Segue support
extension ProfileTabViewController {
  // turn Off all tabbar in nextViews
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let targetVC = segue.destination
    targetVC.hidesBottomBarWhenPushed = true
    
    if let target = targetVC as? SettingViewController {
      target.userProfile = userProfile
    } else if let target = targetVC as? ProfileDetailViewController {
      // cannot pass nil to profileDetailView, UI doesn't allow it
      target.userProfile = userProfile
    } else if let target = targetVC as? BecomeHostViewController {
      target.userProfile = userProfile
    }
  }
}

//MARK:- data drawing functions
extension ProfileTabViewController {
  
  func changeProfileToLoginState() {
    guard let profile = self.userProfile else { return }
    
    let fullName = profile.lastName + " " + profile.firstName
    nameLabel.text = fullName
    
    //draw personal profile image
  }
  
  func changeProfileToLogoutState() {
    nameLabel.text = "회원이신가요?"
    
    //draw default profile image
  }
  
  func changeButtonToLoginState() {
    profileDetailBtn.isHidden = false
    toLoginFlowBtn.isHidden = true
  }
  
  func changeButtonToLogoutState() {
    profileDetailBtn.isHidden = true
    toLoginFlowBtn.isHidden = false
  }
}
