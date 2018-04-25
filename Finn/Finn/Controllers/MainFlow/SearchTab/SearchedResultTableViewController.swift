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
  
  //MARK:- internal data
  var selectedCity: City!
  var fetchedHouse: [House]!
  var fetchedAnnotations: [MKPointAnnotation] = []
  
  var isFetched: Bool = false {
    didSet {
      houseCollection.reloadData()
      addAnnotations()
    }
  }
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    heading.text = selectedCity.cityName + "의 숙소들을 둘러보세요"
    fetchNetworkData()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    //setting mapView's Camera
    let camera = MKMapCamera(lookingAtCenter: CLLocationCoordinate2DMake(selectedCity.latitude, selectedCity.longitude), fromDistance: 16000, pitch: 0, heading: 0)
    mapView.setCamera(camera, animated: true)
  }
  
  //MARK:- network support
  func fetchNetworkData() {
    
    let ne_lat = selectedCity.nelatitude
    let ne_lng = selectedCity.nelongitude
    let sw_lat = selectedCity.swlatitude
    let sw_lng = selectedCity.swlongitude
    
    let requestURL = Network.House.getHouseURL + "?ne_lat=\(ne_lat)&ne_lng=\(ne_lng)&sw_lat=\(sw_lat)&sw_lng=\(sw_lng)"
    
    Alamofire.request(requestURL, method: .get)
    .validate()
      .responseJSON { (response) in
        switch response.result {
        case .success:
          if let data = response.data {
//             let text = String(data: data, encoding: .utf8) {
//            print(text)
            do {
              let list = try JSONDecoder().decode(ListOfHouse.self, from: data)
              self.fetchedHouse = list.results
              print("fetchedHouse: \(self.selectedCity.cityName): \(self.fetchedHouse.count)")
              self.isFetched = true
              
            } catch(let error) {
              print("searchResult: decode failed: \(error.localizedDescription)")
            }
          }
        case .failure(let error):
          print("searchResult: network failed: \(error.localizedDescription)")
        }
    }
  }
  
  func addAnnotations() {
    for i in 0..<fetchedHouse.count {
      let lat = Double(fetchedHouse[i].latitude)!
      let long = Double(fetchedHouse[i].longitude)!
      let point = MKPointAnnotation()
      point.coordinate = CLLocationCoordinate2DMake(lat, long)
      fetchedAnnotations.append(point)
      mapView.addAnnotation(point)
    }

  }
  
  //MARK:- Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
}

//MARK:- CollectionView Support
extension SearchedResultTableViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isFetched {
      return fetchedHouse.count
    } else {
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if isFetched {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HouseCell", for: indexPath) as! HouseCell
      cell.houseTitle.text = fetchedHouse[indexPath.item].name
      cell.houseCost.text = String(fetchedHouse[indexPath.item].accommodationFee) + "원 부터"
      
      guard let _ = fetchedHouse[indexPath.item].imgCoverThumbnail else { return cell }
      
      // do photo fetching
      Alamofire
        .request(self.fetchedHouse[indexPath.item].imgCoverThumbnail)
        .validate()
        .responseData(completionHandler: { (response) in
          switch response.result {
          case .success:
            let image = UIImage(data: response.data!)
            cell.houseThumbnail.image = image
          case .failure(let error):
            print("searchResult: imageDL: requestFailed: \(error.localizedDescription)")
          }
        })
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HouseCell", for: indexPath)
      return cell
    }
  }
  
  
}

extension SearchedResultTableViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let sb = UIStoryboard(name: "HouseDetail", bundle: nil)
    let detailVC = sb.instantiateViewController(withIdentifier: "HouseDetailViewController") as! HouseDetailViewController
    detailVC.house = fetchedHouse[indexPath.item]
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let wholeWidth = collectionView.frame.width
    let wholeContents = (wholeWidth - 10.0 - 10.0 - 10.0)
    let individualContentWidth = wholeContents / 2.0
    return CGSize(width: floor(individualContentWidth), height: 180.0 )
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 10.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsetsMake(4.0, 4.0, 4.0, 4.0)
  }
}

class HouseCell: UICollectionViewCell {
  @IBOutlet weak var houseThumbnail: UIImageView!
  @IBOutlet weak var houseTitle: UILabel!
  @IBOutlet weak var houseCost: UILabel!
}
