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
  @IBOutlet weak var profileImageView: UIImageView!
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
    
//    firstNameTf.borderBottom(height: 1.0, color: .lightGray)
//    lastNameTf.borderBottom(height: 1.0, color: .lightGray)
    userNameTf.borderBottom(height: 1.0, color: .lightGray)
    phoneNumTf.borderBottom(height: 1.0, color: .lightGray)
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
    
    lastNameTf.text = profile.lastName
    firstNameTf.text = profile.firstName
    userNameTf.text = profile.userName
    phoneNumTf.text = profile.phoneNumber
  }
  
}

