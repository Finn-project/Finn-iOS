//
//  SearchFiltersViewController.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 16..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class SearchFiltersViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    searchBar.becomeFirstResponder()
  }
  
}

//MARK:- IBActions
extension SearchFiltersViewController {
  @IBAction func returnToSearchTab(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func doSearch(_ sender: UIBarButtonItem) {
    
  }
}

//MARK:- searchbar support
extension SearchFiltersViewController: UISearchBarDelegate {
  
}
