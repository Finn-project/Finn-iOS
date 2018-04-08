//
//  WelcomeLoginViewController.swift
//  Finn
//
//  Created by 배지호 on 2018. 4. 2..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import Alamofire
import FacebookCore
import FacebookLogin

class WelcomeLoginViewController: UIViewController {
  
  //MARK:- IBOutlets
  @IBOutlet weak var kakaoLogin: UIButton!
  @IBOutlet weak var facebookLogin: UIButton!
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

//MARK:- IBActions
extension WelcomeLoginViewController {
  @IBAction func kakaoLoginAction(_ sender: Any) {
    
  }
  
  @IBAction func facebookLoginAction(_ sender: Any) {
    let fbLoginManager = LoginManager()
    //removes login record on facebook server
    fbLoginManager.logOut()
    
    fbLoginManager.logIn(readPermissions: [.publicProfile], viewController: self) {
      (fbLoginResult) in
      switch fbLoginResult {
      case .failed(let error):
        print("facebook login: failed: \(error.localizedDescription)")
      case .cancelled:
        print("acebook login: cancelled: user cancelled")
      case .success(let granted, let declined, let accessToken):
        print("facebook login: success")
        print("\(granted) / \(declined): \(accessToken)")
        
        // shoot accessToken to our server
        var parameters: [String: String] = [:]
        parameters.updateValue(accessToken.authenticationToken, forKey: "access_token")

        Alamofire
          .request(Network.Auth.fbLoginURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
                    print("fb login: success, writtenToken: \(writtenToken)")
                  }

                  self.dismiss(animated: true, completion: nil)

                } catch (let error) {
                  print("fb login: decode failed, \(error.localizedDescription)")
                }
              }
            case .failure(let error):
              print("fb login: post failed, \(error.localizedDescription)")
            }
        }
      }
    }
  }
  
  @IBAction func back(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
