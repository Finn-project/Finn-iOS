//
//  LoginViewController.swift
//  Finn
//
//  Created by 배지호 on 2018. 4. 2..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginEmailTF: UITextField!
    @IBOutlet weak var loginPWTF: UITextField!
    
    //MARK: - Gesture
    @IBAction func removeKeyboard(_ sender: Any) {
        loginEmailTF.resignFirstResponder()
        loginPWTF.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginEmailTF.borderBottom(height: 1.0, color: UIColor.white)
        loginPWTF.borderBottom(height: 1.0, color: UIColor.white)
    }
}

//MARK: - extension: UITextField
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if loginEmailTF.text == "" {
            loginEmailTF.becomeFirstResponder()
        } else {
            loginEmailTF.resignFirstResponder()
            loginPWTF.becomeFirstResponder()
        }
        return true
    }
}
