//
//  SettingViewController.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 3..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
  
  //MARK:- IBOutlets
  @IBOutlet weak var logoutBtn: UIButton!
  
  //MARK:- data property
  var userProfile: UserProfile!
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let _ = userProfile {
      drawButtonsToLoginState()
    }
  }

}

//MARK:- IBActions
extension SettingViewController {
  
  @IBAction func logoutTapped() {
    userProfile.resetUserDefaults()
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func readDisclaimer() {
    // link to Disclaimer!
  }
}

//MARK:- drawing functions
extension SettingViewController {
  
  func drawButtonsToLoginState() {
    logoutBtn.isHidden = false
  }
}
