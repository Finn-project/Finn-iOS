//
//  ProfileViewController.swift
//  Finn
//
//  Created by 배지호 on 2018. 4. 2..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class ProfileTabViewController: UIViewController {
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

//MARK:- Segue support
extension ProfileTabViewController {
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let targetVC = segue.destination as UIViewController
    targetVC.hidesBottomBarWhenPushed = true
  }
}
