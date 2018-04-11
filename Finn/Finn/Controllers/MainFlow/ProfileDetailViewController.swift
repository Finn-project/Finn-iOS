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
  @IBOutlet weak var userNameTf: UITextField!
  @IBOutlet weak var userNameLb: UILabel!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var userFullNameTf: UITextField!
  @IBOutlet weak var emailTf: UITextField!
  @IBOutlet weak var phoneNumTf: UITextField!
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    drawUserProfile()
  }
  //MARK: - drawing textFields
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    userNameTf.borderBottom(height: 1.0, color: .darkGray)
    emailTf.borderBottom(height: 1.0, color: .darkGray)
    phoneNumTf.borderBottom(height: 1.0, color: .darkGray)
    userFullNameTf.borderBottom(height: 1.0, color: .darkGray)
    
    userNameTf.isUserInteractionEnabled = false
    emailTf.isUserInteractionEnabled = false
    phoneNumTf.isUserInteractionEnabled = false
    userFullNameTf.isUserInteractionEnabled = false
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
    guard let profile = self.userProfile else {return}
    let fullName = profile.lastName + " " + profile.firstName
    
    userNameLb.text = fullName
    userNameTf.text = profile.userName
    emailTf.text = profile.email
    userFullNameTf.text = fullName
    phoneNumTf.text = profile.phoneNumber
  }
  //MARK: get UserProfileImage frome server
//  func drawProfileImgFromServer(url: String) {
//    Alamofire
//      .request(url, method: .get)
//      .response {
//        (response) in
//        self.profileImageView.image = UIImage(data: response.data!, scale: 1)
//    }
//  }
}

