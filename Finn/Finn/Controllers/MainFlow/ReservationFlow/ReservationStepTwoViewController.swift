//
//  ReservationStepTwoViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class ReservationStepTwoViewController: UIViewController {

  var segue: String = "finalReservationViewController"
  
  @IBAction func nextButton(_ sender: Any) {
    performSegue(withIdentifier: segue, sender: self)
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

    }
}
