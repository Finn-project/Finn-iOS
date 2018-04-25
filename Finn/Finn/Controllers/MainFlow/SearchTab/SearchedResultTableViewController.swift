//
//  SearchedResultTableViewController.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 25..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class SearchedResultTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
}
