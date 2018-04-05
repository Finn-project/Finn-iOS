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
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }

}

//MARK:- IBActions
extension SearchTabViewController {
  @IBAction func wallTapped() {
    searchBar.resignFirstResponder()
  }
}
