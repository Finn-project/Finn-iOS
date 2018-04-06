//
//  RoomAddressViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import MapKit //지오코딩 ->(구글맵 주소->위도경도알아내기)

class RoomAddressViewController: UIViewController {
  
  var matchingItems: [MKMapItem] = [MKMapItem]()
  //MARK: IBOutlets
  @IBOutlet weak var inputAddressTf: UITextField!
  @IBOutlet weak var mapView: MKMapView!
  @IBAction func textFieldReturn(_ sender: Any){
    resignFirstResponder()
    self.performSearch()

    
  }
  @IBAction func removeAnnotation(_ sender: Any){
//    mapView.removeAnnotation(mapView.annotations as! MKAnnotation)
    
  }
  func performSearch(){
    matchingItems.removeAll()
    let request = MKLocalSearchRequest()
    request.naturalLanguageQuery = inputAddressTf.text
    request.region = mapView.region
    
    let search = MKLocalSearch(request: request)
    search.start { (response: MKLocalSearchResponse!, error: Error!) in
      if error != nil{
        print("error")
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
          
          self.mapView.addAnnotation(annotation)
        }
      }
    }
  }
    override func viewDidLoad() {
        super.viewDidLoad()
      inputAddressTf.becomeFirstResponder()
      var cam = mapView.camera
      cam.pitch = 0
      // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: tap Gesture
extension RoomAddressViewController{
  @IBAction func removeKeyboard(_ sender: Any){
    inputAddressTf.resignFirstResponder()
  }
}
//MARK: textfieldDelegate
//extension RoomAddressViewController: UITextFieldDelegate{
//
//  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//    inputAddressTf.resignFirstResponder()
//    return true
//  }
//}
