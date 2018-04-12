//
//  ProfileViewController.swift
//  Finn
//
//  Created by 배지호 on 2018. 4. 2..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import Alamofire

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
//    self.navigationController?.setNavigationBarHidden(true, animated: false)

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
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
//    self.navigationController?.setNavigationBarHidden(false, animated: false)
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

//MARK:- data state drawing functions
extension ProfileTabViewController {
  
  func changeProfileToLoginState() {
    guard let profile = self.userProfile else { return }
    
    let fullName = profile.lastName + "  " + profile.firstName
    nameLabel.text = fullName
    
    // draw profileImage if needed
    let profileImageURL = profile.profileImg
    if profileImageURL != "0000" {
      drawProfileImgFromServer(url: profileImageURL)
    } else {
      profileImgView.image = #imageLiteral(resourceName: "defaultProfileImg")
    }
   
  }
  
  func changeProfileToLogoutState() {
    nameLabel.text = "회원이신가요?"
    profileImgView.image = #imageLiteral(resourceName: "defaultProfileImg")
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

//MARK:- networking - need to be saved in cache
extension ProfileTabViewController {
  func drawProfileImgFromServer(url: String) {
    
    Alamofire
      .request(url, method: .get)
      .response {
        (response) in
        self.profileImgView.image = UIImage(data: response.data!, scale: 1)
    }
  }
}
