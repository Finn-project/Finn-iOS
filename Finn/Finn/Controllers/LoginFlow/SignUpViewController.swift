//
//  SignUpViewController.swift
//  Finn
//
//  Created by 배지호 on 2018. 4. 2..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBAction func removeKeyboard(_ sender: Any) {
        firstNameTF.resignFirstResponder()
        lastNameTF.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTF.borderBottom(height: 1.0, color: UIColor.white)
        lastNameTF.borderBottom(height: 1.0, color: UIColor.white)
    }
}

extension UITextField {
    func borderBottom(height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height-height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}

extension SignUpViewController {
    
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if firstNameTF.text == "" {
            firstNameTF.becomeFirstResponder()
        } else {
            firstNameTF.resignFirstResponder()
            lastNameTF.becomeFirstResponder()
        }
        return true
    }
    
}
