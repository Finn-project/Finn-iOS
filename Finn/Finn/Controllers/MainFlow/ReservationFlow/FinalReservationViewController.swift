//
//  FinalReservationViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import FSCalendar
class FinalReservationViewController: UIViewController {

  //MARK:- IBOutlet
  @IBOutlet weak var finalCalendar: FSCalendar!
  
  //MARK:- Internal Properties
  let gregorian = Calendar(identifier: .gregorian)
  let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  var house: House!
  //MARK: -LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    finalCalendar.scrollDirection = .vertical
    finalCalendar.swipeToChooseGesture.isEnabled = true
    finalCalendar.allowsMultipleSelection = true
    print("\(house)")
    self.finalCalendar.accessibilityIdentifier = "finalCalendar"
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.finalCalendar.reloadData()
    print("viewWillAppear")
  }
}

////MARK: -FSCAlendarDelegate
//extension FinalReservationViewController: FSCalendarDelegate {
//  func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
//    if self.finalCalendar.today! > date {
//      cell.titleLabel.alpha = 0.2
//    }
//    if (date == self.formatter.date(from: )!) {
//      cell.titleLabel.textColor = UIColor.orange
//    }
//  }
  //MARK: shouldSelect
//  func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//    for i in
//    let dt = self.formatter.date(from: testsouce)!
//    if (date == dt) {
//      return false
//    }
//    return true
//  }
//}

//MARK: -FSCalendarDataSource
extension FinalReservationViewController: FSCalendarDataSource {
  //MARK: todayBeforeSelect
  func minimumDate(for calendar: FSCalendar) -> Date {
    return Date()
  }
  
  //MARK: TodayMaximumDate
  func maximumDate(for calendar: FSCalendar) -> Date {
    let threeMonthFromNow = self.gregorian.date(byAdding: .month, value: 2, to: Date(), wrappingComponents: true)
    return threeMonthFromNow!
  }
}

