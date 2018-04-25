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
  var house: House!
  @IBAction func nextButton(_ sender: Any) {
    performSegue(withIdentifier: segue, sender: self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(house)
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let finalCalendar = segue.destination as? FinalReservationViewController else { return }
    finalCalendar.house = house
  }
}
