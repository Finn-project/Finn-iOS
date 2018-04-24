//
//  ViewController.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 2..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import Alamofire

class SearchTabViewController: UIViewController {

  //MARK:- IBOutlets
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var wholePage: UITableView!
  
  
  //MARK:- internal properties
  var isSearching: Bool = false
  var searchedData: [House] = []
  var searchedPKs: [Int] = []
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    fetchDataSource()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.setNavigationBarHidden(false, animated: false)
  }

}

//MARK:- IBActions
extension SearchTabViewController {
  @IBAction func wallTapped() {
    searchBar.resignFirstResponder()
  }
}

extension SearchTabViewController {
  func fetchDataSource() {
    Alamofire
      .request(Network.House.getHouseURL, method: .get, encoding: JSONEncoding.default)
      .validate()
      .responseJSON { (response) in
        switch response.result {
        case .success:
          if let data = response.data {
//             let text = String(data: data, encoding: .utf8) {
//            print(text)
            do {
              let houses = try JSONDecoder().decode(ListOfHouse.self, from: data)
//              print("searchTab: decode success")
              
              // do repackaging for collectionView cells
              for i in 0..<20 {
                self.searchedPKs.append(houses.results[i].pk)
                self.searchedData.append(houses.results[i])
              }
              
              self.wholePage.reloadData()
//              let sectionRow = self.wholePage.cellForRow(at: IndexPath(row: 0, section: 2) ) as! CatalogSectionCell
//              sectionRow.houseCatalogCollection.reloadData()
              
              
            } catch(let error) {
              print("searchTab: decode failed, \(error.localizedDescription.debugDescription)")
            }
          }
        case .failure(let error):
          print("searchTab: network failed, \(error.localizedDescription.debugDescription) ")
        }
    }
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
      return 2 + (searchedData.count / 4)
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
        if let newCell = tableView.dequeueReusableCell(withIdentifier: "Catalog", for: indexPath) as? CatalogSectionCell {
          newCell.sectionHeading.text = "최근 등록된 숙소들을 둘러보세요"
          newCell.houseCatalogCollection.reloadData()
        }
      }
    }
    return cell
  }
  
}

extension SearchTabViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if isSearching {
      return 240
    } else {
      if indexPath.section == 0 {
        return 88 // heading section
      } else if indexPath.section == 1 {
        return 200 // (72 + 100 + 8)
      } else {
        return 420
      }
    }
  }
  
}

//MARK:- CollectionView support
extension SearchTabViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView.tag == 0 {
      return 7
    } else {
      return searchedData.count
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView.tag == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCell", for: indexPath) as! CityCell
      cell.imageView.image = UIImage(named: cities[indexPath.item].cityImage)!
      cell.cityName.text = cities[indexPath.item].cityName
      return cell
    } else { //if collectionView.tag == 1
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatalogCell", for: indexPath) as! CatalogCell
      cell.houseName.text = searchedData[indexPath.item].name
      cell.housePrice.text = String(searchedData[indexPath.item].accommodationFee) + "원 부터"
      
      Alamofire
        .request(self.searchedData[indexPath.item].imgCoverThumbnail)
        .validate()
        .responseData(completionHandler: { (response) in
          switch response.result {
          case .success:
            let image = UIImage(data: response.data!)
            cell.houseThumbnail.image = image
          case .failure(let error):
            print("searchTab: imageDL: requestFailed: \(error.localizedDescription)")
          }
      })
      return cell
    }
    
  }
  
}

extension SearchTabViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView.tag == 0 {
      let wholeWidth = collectionView.frame.width
      let wholeContents = (wholeWidth - 10.0 - 10.0 - 10.0)
      let individualContentWidth = wholeContents / 2.0
      let contentHeight = individualContentWidth * 10.0 / 16.0
      return CGSize(width: floor(individualContentWidth), height: floor(contentHeight) )
    } else {
      let wholeWidth = collectionView.frame.width
      let wholeContents = (wholeWidth - 10.0 - 10.0 - 10.0)
      let individualContentWidth = wholeContents / 2.0
      return CGSize(width: floor(individualContentWidth), height: 180.0 )
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 10.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsetsMake(4.0, 0.0, 4.0, 0.0)
  }
  
}

//MARK:- UITableView Catalog Section Cell
class CatalogSectionCell: UITableViewCell {
  @IBOutlet weak var sectionHeading: UILabel!
  @IBOutlet weak var houseCatalogCollection: UICollectionView!
}



