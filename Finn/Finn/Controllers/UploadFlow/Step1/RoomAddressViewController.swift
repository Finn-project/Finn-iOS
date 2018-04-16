//
//  RoomAddressViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import MapKit //지오코딩 ->(구글맵 주소->위도경도알아내기)
import CoreLocation
class RoomAddressViewController: UIViewController {
  
  var matchingItems: [MKMapItem] = [MKMapItem]()
  //MARK: IBOutlets
  @IBOutlet weak var inputAddressTf: UITextField!
  @IBOutlet weak var mapView: MKMapView!
  //MARK: IBaction
  @IBAction func textFieldReturn(_ sender: Any){
    resignFirstResponder()
    mapView.removeAnnotations(mapView.annotations)
    self.performSearch()
}
  //MARK:- Internal Property
  var houseInfoData: [String: Any] = [:]
  var addressInfoData: [String: Any] = [:]
  var addressForUpload: AddressForInternal = AddressForInternal()
  
  var latitude: Double = 0.0
  var longitude: Double = 0.0
  var country: String = ""
  var administrativeArea: String = ""
  var locality: String = ""
  var subLocality: String = ""
  var subThoroughfare: String = ""
  
  //MARK: Search action 
  func performSearch(){
    matchingItems.removeAll()
    let request = MKLocalSearchRequest()
    request.naturalLanguageQuery = inputAddressTf.text
    request.region = mapView.region
    
    
    let search = MKLocalSearch(request: request)
    search.start { (response: MKLocalSearchResponse!, error: Error!) in
      if error != nil{
        print("\(error.localizedDescription)")
      }else if response.mapItems.count == 0{
        print("no matches found")
      }else{
        print("found")
        for item in response.mapItems as [MKMapItem]{
          if item.name != nil{
            print("Name = \(item.name!)")
          }
          if item.phoneNumber != nil{
            print("Phone = \(item.phoneNumber!)")
          }
          
          self.matchingItems.append(item as MKMapItem)
          let annotation = MKPointAnnotation()
          annotation.coordinate = item.placemark.coordinate
          
          annotation.title = item.name
          annotation.subtitle = item.phoneNumber
          
          //MARK: latitude & longitude fit to center, Change altitude value ?? 문법이 맞는지 모르겠음
          let camera = self.mapView.camera
          camera.centerCoordinate = item.placemark.coordinate
          camera.altitude = 500
//          print(annotation.coordinate.latitude)
//          print(annotation.coordinate.longitude)
          self.mapView.addAnnotation(annotation)
          self.geocode(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude, completion: { (placemark, error) in
           
            guard let placemark = placemark else {return}
           
            print("name: ", placemark.name ?? "")
            print("country: ", placemark.country ?? "") //나라
            self.country = placemark.country!
            //시, 도
            print("administrativeArea : ", placemark.administrativeArea ?? "")
            
            print("subAdiministrativeArea : ", placemark.subAdministrativeArea ?? "")
            //구
            print("locality : ", placemark.locality ?? "")
            //동,면
            print("subLocality : ", placemark.subLocality ?? "")
            //동, 리
            print("thoroughfare : ", placemark.thoroughfare ?? "")
            //지번
            print("subThoroughfare : ", placemark.subThoroughfare ?? "")
            print(annotation.coordinate.latitude)
            print(annotation.coordinate.longitude)
            self.administrativeArea = placemark.administrativeArea ?? ""
            self.locality = placemark.locality ?? ""
            self.subLocality = placemark.subLocality ?? ""
            self.subThoroughfare = placemark.subThoroughfare ?? ""
            self.latitude = annotation.coordinate.latitude
            self.longitude = annotation.coordinate.longitude
            
          })
          
        }
      }
    }
  }
  //MARK:- reverseGeocode function
  //
  ///  Convert latitude&longitude to address
  ///
  /// - Parameters:
  ///   - latitude: Search result latitude
  ///   - longitude: Search result longitude
  ///   - completion: reverseGeocodeLocation
  func geocode(latitude: Double, longitude: Double, completion: @escaping (CLPlacemark?, Error?) -> ())  {
    CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { completion($0?.first, $1) }
  }
    override func viewDidLoad() {
        super.viewDidLoad()
      inputAddressTf.becomeFirstResponder()
      // Do any additional setup after loading the view.
      print(houseInfoData)
    }

  //MARK:-  prepare
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let convenientVC = segue.destination as? ConvenientViewController else { return }
    addressForUpload.city = administrativeArea
    addressForUpload.district = locality
    addressForUpload.dong = subLocality
    addressForUpload.firstDetailAddress = subThoroughfare
    
    convenientVC.addressforupload = addressForUpload
  }
  

}
//MARK: tap Gesture
extension RoomAddressViewController{
  @IBAction func removeKeyboard(_ sender: Any){
    inputAddressTf.resignFirstResponder()
  }
}


