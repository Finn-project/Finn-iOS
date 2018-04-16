//
//  ViewController.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 2..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class SearchTabViewController: UIViewController {

  //MARK:- IBOutlets
  @IBOutlet weak var searchBar: UISearchBar!
  
  //MARK:- internal properties
  var isSearching: Bool = false
  var searchedData: [House] = []
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.navigationBar.isHidden = false
  }

}

//MARK:- IBActions
extension SearchTabViewController {
  @IBAction func wallTapped() {
    searchBar.resignFirstResponder()
  }
}

//MARK: Searchbar Support
extension SearchTabViewController: UISearchBarDelegate {
  
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    defer {
      let sb = UIStoryboard(name: "MainFlow", bundle: nil)
      let filterVC = sb.instantiateViewController(withIdentifier: "SearchFiltersViewController")
      self.present(filterVC, animated: true, completion: nil)
    }
    return false
  }
}

//MARK:- TableView Support
extension SearchTabViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    if isSearching {
      return searchedData.count
    } else {
      return (2 + 3) // current searchedData.count = 3
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell = UITableViewCell()
    
    if isSearching {
      cell = tableView.dequeueReusableCell(withIdentifier: "Catalog", for: indexPath)
    } else {
      if indexPath.section == 0 {
        cell = tableView.dequeueReusableCell(withIdentifier: "Heading", for: indexPath)
      } else if indexPath.section == 1 {
        cell = tableView.dequeueReusableCell(withIdentifier: "CityIndex", for: indexPath)
      } else {
        cell = tableView.dequeueReusableCell(withIdentifier: "Catalog", for: indexPath)
      }
    }
    return cell
  }
  
}

extension SearchTabViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if isSearching {
      return 200
    } else {
      if indexPath.row == 0 {
        return 420
      } else if indexPath.row == 1 {
        return 320
      } else {
        return 240
      }
    }
  }
}
