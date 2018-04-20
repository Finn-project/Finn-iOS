//
//  ReservationSettingViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import Alamofire

class ReservationSettingViewController: UIViewController {
  
  @IBOutlet weak var payTF: UITextField!
  var list: [String] = []
  @IBOutlet weak var setPriceTf:UITextField!
  override func viewDidLoad() {
    super.viewDidLoad()
    payTF.drawBottomBorder(backColor: .white, withColor: .lightGray)
    print("\(list)")
  }
}
