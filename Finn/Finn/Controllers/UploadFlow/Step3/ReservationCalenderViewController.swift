//
//  ReservationCalenderViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import FSCalendar

class ReservationCalenderViewController: UIViewController {
  
  @IBOutlet weak var calendar: FSCalendar!
  fileprivate let gregorian = Calendar(identifier: .gregorian)
  fileprivate let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  let segue: String = "calendarNextStep"
  var stack = Stack<String>()
  var cell: FSCalendarEventIndicator!
  var date: Date!
  //MARK: GO TO UploadIntro
  @IBAction func backToIntro(_ sender: Any){
    
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    calendar.scrollDirection = .vertical
    calendar.swipeToChooseGesture.isEnabled = true
    calendar.allowsMultipleSelection = true
    self.calendar.accessibilityIdentifier = "calendar"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.calendar.reloadData()
  }
}
extension ReservationCalenderViewController: FSCalendarDelegate {
  
  func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    let selectData = self.formatter.string(from: date)
    print("selectData: \(selectData)")
    self.stack.push(selectData)
  }
  
  func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
    let deselectData = self.formatter.string(from: date)
    print("deselectData:\(deselectData)")
  }
  //monthCount
  func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
    let currentMonth = calendar.month(of: calendar.currentPage)
    print("PageMonth: \(currentMonth)")
  }
  //
  func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
    let selectData = self.formatter.string(from: date)
    if self.calendar.today! > date {
      return false
    }
    return true
  }
  //
  func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
    let selectData = self.formatter.string(from: date)
    if selectData == self.stack.list.last {
      self.stack.pop()
    } else {
      return false
    }
    return true
  }
  
  func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
    if self.calendar.today! > date {
      cell.titleLabel.textColor = UIColor.red
    }
  }
}

extension ReservationCalenderViewController: FSCalendarDataSource {
  
  func minimumDate(for calendar: FSCalendar) -> Date {
    return Date()
  }
  func maximumDate(for calendar: FSCalendar) -> Date {
    let threeMonthFromNow = self.gregorian.date(byAdding: .month, value: 2, to: Date(), wrappingComponents: true)
    return threeMonthFromNow!
  }
}

