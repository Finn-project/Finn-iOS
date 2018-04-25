//
//  SettingViewController.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 3..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import Alamofire

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
  
    var requestHeader: HTTPHeaders = [:]
    requestHeader.updateValue("Token " + User.loadTokenFromUserDefaults()!, forKey: "Authorization")

    Alamofire
      .request(Network.Auth.logoutURL, method: .post, encoding: JSONEncoding.default, headers: requestHeader)
      .responseJSON { (response) in
      switch response.result {
      case .success:
        if let _ = response.data {
//            let text = String(data: data, encoding: .utf8) {
//              print(text) // possible modal??
            self.userProfile.resetUserDefaults()
            self.navigationController?.popViewController(animated: true)
          }
      case .failure(let error):
        print("logout post failed : \(error.localizedDescription)")
      }
    }
  }
  
  @IBAction func readDisclaimer() {
    // link to Disclaimer! maybe an easter egg for us
  }
}

//MARK:- drawing functions
extension SettingViewController {
  
  func drawButtonsToLoginState() {
    logoutBtn.isHidden = false
  }
}
