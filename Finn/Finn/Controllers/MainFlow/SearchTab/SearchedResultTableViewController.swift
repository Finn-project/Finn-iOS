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
  
  //MARK:- IBOutlets
  @IBOutlet weak var heading: UILabel!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var houseCollection: UICollectionView!
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //MARK:- Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
}

//MARK:- CollectionView Support
extension SearchedResultTableViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HouseCell", for: indexPath)
    return cell
  }
  
  
}

extension SearchedResultTableViewController: UICollectionViewDelegateFlowLayout {
  
}
