//
//  WelcomeLoginViewController.swift
//  Finn
//
//  Created by 배지호 on 2018. 4. 2..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class WelcomeLoginViewController: UIViewController {

    @IBOutlet weak var kakaoLogin: UIButton!
    @IBOutlet weak var facebookLogin: UIButton!
    
    @IBAction func kakaoLoginAction(_ sender: Any) {
        
    }
    
    @IBAction func facebookLoginAction(_ sender: Any) {
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
