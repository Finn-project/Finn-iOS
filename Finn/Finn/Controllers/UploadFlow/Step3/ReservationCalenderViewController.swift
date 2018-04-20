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
  var stack = Stack()
  var cell: FSCalendarEventIndicator!
  var date: Date!
  //MARK: GO TO UploadIntro
  @IBAction func backToIntro(_ sender: Any){
    if stack.isEmpty {
      let alertAC = UIAlertController(title: "날짜를 선택해주세요.", message: "", preferredStyle: .alert)
      let action = UIAlertAction(title: "네", style: .default)
      alertAC.addAction(action)
      present(alertAC, animated: true, completion: nil)
    } else if stack.list.count == 1 {
      let alertAC = UIAlertController(title: "날짜를 정확히 입력해주세요.", message: "", preferredStyle: .alert)
      let action = UIAlertAction(title: "네", style: .default)
      alertAC.addAction(action)
      present(alertAC, animated: true, completion: nil)
    }
    performSegue(withIdentifier: segue, sender: self)
  }
  //MARK: -LifeCycle
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
    print("viewWillAppear")
  }
}

extension ReservationCalenderViewController: FSCalendarDelegate {
  //select 하고난 뒤
  func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    let selectData = self.formatter.string(from: date)
    print("selectData: \(selectData)")
    self.stack.push(selectData)
    print("\(self.stack.list)")
  }
  //선택된 날짜를 다시 선택해제한 뒤
  func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
    let deselectData = self.formatter.string(from: date)
    self.stack.pop()
    print("\(self.stack.list)")
    print("deselectData:\(deselectData)")
  }
  //monthCount
  func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
    let currentMonth = calendar.month(of: calendar.currentPage)
    print("PageMonth: \(currentMonth)")
  }
  //
  func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
    let selectData = self.formatter.string(from: date)
    if selectData == String(self.stack.list.startIndex) {
      self.stack.list.removeAll()
    }
    return true
  }
  
  func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
    if self.calendar.today! > date {
      cell.titleLabel.alpha = 0.4
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

