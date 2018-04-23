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
  
  //MARK:- IBOutlets
  @IBOutlet weak var calendar: FSCalendar!
  
  //MARK:- IBAction
  @IBAction func backToIntro(_ sender: Any) {
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
  //MARK:- Internal Properties
  fileprivate let gregorian = Calendar(identifier: .gregorian)
  fileprivate let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  let segue: String = "calendarNextStep"
  var stack = Stack()
  var cell: FSCalendarEventIndicator!
  var testsouce: String = "2018-04-30"
  
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
  
  //MARK:- prepare
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let settingVC = segue.destination as? ReservationSettingViewController else { return }
    settingVC.list = self.stack.list
  }
}

//MARK: -FSCalendarDelegate
extension ReservationCalenderViewController: FSCalendarDelegate {
  //select 하고난 뒤
  func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    let selectData = self.formatter.string(from: date)
    print("selectData: \(selectData)")
    self.stack.push(selectData)
    print("\(self.stack.list)")
  }
  //MARK: 선택된 날짜를 다시 선택해제한 뒤
  func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
    let deselectData = self.formatter.string(from: date)
    self.stack.pop()
    print("\(self.stack.list)")
    print("deselectData:\(deselectData)")
  }
  //MARK: monthCount
  func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
    let currentMonth = calendar.month(of: calendar.currentPage)
    print("PageMonth: \(currentMonth)")
  }
  //MARK: whilDisplayCell
  func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
    if self.calendar.today! > date {
      cell.titleLabel.alpha = 0.2
    }
    if (date == self.formatter.date(from: testsouce)!) {
      cell.titleLabel.alpha = 0.2
    }
  }
  //MARK: shouldSelect
  func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
    let dt = self.formatter.date(from: testsouce)!
    if (date == dt) {
      return false
    }
    return true
  }
}

//MARK: -FSCalendarDataSource
extension ReservationCalenderViewController: FSCalendarDataSource {
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


