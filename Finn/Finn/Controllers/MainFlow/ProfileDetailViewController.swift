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
  @IBOutlet weak var nameLb: UILabel!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var userNameLb: UILabel!
  @IBOutlet weak var emailLb: UILabel!
  @IBOutlet weak var lastNameLb: UILabel!
  @IBOutlet weak var firstNameLb: UILabel!
  @IBOutlet weak var phoneNumberLb: UILabel!
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    drawUserProfile()
  }
}

//MARK:- IBActions
extension ProfileDetailViewController {
  @IBAction func rewindFromEditView(_ sender: UIStoryboardSegue) {
  }
}

//MARK:- drawing function
extension ProfileDetailViewController {
  func drawUserProfile() {
    if User.checkCurrentUser(){
      guard let profile = self.userProfile else {return}
      let fullName = profile.lastName + " " + profile.firstName
      nameLb.text = fullName
      userNameLb.text = profile.userName
      emailLb.text = profile.email
      lastNameLb.text = profile.lastName
      firstNameLb.text = profile.firstName
      phoneNumberLb.text = profile.phoneNumber
      let profileImageURL = profile.profileImg
      drawProfileImgFromServer(url: profileImageURL)
     
    }
  }
  //MARK: get UserProfileImage frome server
  func drawProfileImgFromServer(url: String) {
    Alamofire
      .request(url, method: .get)
      .response {
        (response) in
        self.profileImageView.image = UIImage(data: response.data!, scale: 1)
    }
  }
}

