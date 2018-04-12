//
//  ProfilePasswordChangeViewController.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 12..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import Alamofire

class ProfilePasswordChangeViewController: UIViewController {
  
  //MARK:- IBOutlets
  @IBOutlet weak var viewTitleLbl: UILabel!
  
  @IBOutlet weak var currentPWLbl: UILabel!
  @IBOutlet weak var currentPWLblCenter: NSLayoutConstraint!
  @IBOutlet weak var currentPWTf: UITextField!
  
  @IBOutlet weak var newPWLbl: UILabel!
  @IBOutlet weak var newPWTf: UITextField!
  @IBOutlet weak var confirmPWLbl: UILabel!
  @IBOutlet weak var confirmPWTf: UITextField!
  
  //MARK:- internal data
  var isConfirmed: Bool = false {
    didSet {
      if isConfirmed {
        drawConfirmedState()
      }
    }
  }
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    drawInitialState()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    currentPWTf.borderBottom(height: 1.0, color: .lightGray)
    newPWTf.borderBottom(height: 1.0, color: .lightGray)
    confirmPWTf.borderBottom(height: 1.0, color: .lightGray)
  }
}

//MARK:- Button Selectors
extension ProfilePasswordChangeViewController {
  
  @objc func checkCurrentPassword() {
    // do psudo-login to check current password
    isConfirmed = true
  }
  
  @objc func changePassword() {
    self.navigationController?.popViewController(animated: true)
  }
}

//MARK:- state change functions
extension ProfilePasswordChangeViewController {
  func drawInitialState() {
    currentPWLblCenter.constant = -92
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인하기", style: .plain,
                                                             target: self, action: #selector(self.checkCurrentPassword))
    
    //prepare animation initial frame
    newPWLbl.center.x += view.bounds.width
    newPWTf.center.x += view.bounds.width
    confirmPWLbl.center.x += view.bounds.width
    confirmPWTf.center.x += view.bounds.width
  }
  
  func drawConfirmedState() {
    currentPWLblCenter.constant = -192
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "변경하기", style: .plain,
                                                             target: self, action: #selector(self.changePassword))
    
    newPWLbl.isHidden = false
    newPWTf.isHidden = false
    confirmPWLbl.isHidden = false
    confirmPWTf.isHidden = false
    
    //animate here
    UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
      self.newPWLbl.center.x -= self.view.bounds.width
      self.newPWTf.center.x -= self.view.bounds.width
      self.confirmPWLbl.center.x -= self.view.bounds.width
      self.confirmPWTf.center.x -= self.view.bounds.width
    }, completion: nil)
    
    currentPWLbl.isHidden = true
    currentPWTf.isHidden = true
    
  }
}
