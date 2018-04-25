//
//  ReservationStepOneViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class ReservationStepOneViewController: UIViewController {

  
  var house: House!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      print("\(house)")
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print("viewDidAppear: \(house)")
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let finalCalendar = segue.destination as? ReservationStepTwoViewController else { return }
    finalCalendar.house = house
  }
  @IBAction func dismissToDetailView(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
}
