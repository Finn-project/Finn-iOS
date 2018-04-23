//
//  RoomImagePreviewViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class RoomImagePreviewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  //MARK:- property
  var imagePicker = UIImagePickerController()
  var tmpImg = UIImageView()
  var tmpURL = ""
  //MARK:- IBOutlets
  @IBOutlet weak var roomImage: UIImageView!
  @IBOutlet weak var imageAddBtn: UIButton!
  
  //MARK:- Internal Property
  var stepTwo: HouseInfoStepTwoForInternal = HouseInfoStepTwoForInternal()
  //MARK:- IBActions
  @IBAction func addAction(_ sender: UIButton) {
   
    let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "지금 사진 찍기", style: .default, handler: { _ in
      self.openCamera()
    }))
    alert.addAction(UIAlertAction(title: "갤러리에서 선택", style: .default, handler: { _ in
      self.openGallery()
    }))
    
    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
      alert.popoverPresentationController?.sourceView = sender
      alert.popoverPresentationController?.sourceRect = sender.bounds
      alert.popoverPresentationController?.permittedArrowDirections = .up
    default:
      break
    }
    self.present(alert, animated: true, completion: nil)
    
  }
    override func viewDidLoad() {
          super.viewDidLoad()
        imagePicker.delegate = self
          // Do any additional setup after loading the view.
      }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      roomImage.image = tmpImg.image
    }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let descriptVC = segue.destination as? RoomDescriptViewController else {return}
    
    stepTwo.roomImageURL = tmpURL
    print("tmpurl : ", tmpURL)
    descriptVC.stepTwo = stepTwo
  }
  
  
}
extension RoomImagePreviewViewController {
  
  func openCamera() {
    if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
      imagePicker.sourceType = UIImagePickerControllerSourceType.camera
      imagePicker.allowsEditing = true
      self.present(imagePicker, animated: true, completion: nil)
    }else {
      let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  func openGallery() {
    imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
    imagePicker.allowsEditing = true
    self.present(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
      tmpImg.image = pickedImage
    }
    //MARK:- deprecated 됨 찾는중
//    if let pickerImageURL = info[UIImagePickerControllerReferenceURL] as? URL {
//      print(pickerImageURL)
//
//    }
    //아래 방법으로 url 뽑았는데 정확한지 확인 예정
    if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
      
//      print(documentDirectory)
      let photoURL = URL(fileURLWithPath: documentDirectory)
//      print(photoURL)
      let path = photoURL.path
      tmpURL = path
      print(path)
    }
    
    
 
    
    self.dismiss(animated: true, completion: nil)
  }
}

