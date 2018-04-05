//
//  UploadIntroViewController.swift
//  Finn
//
//  Created by choi hyunho on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class UploadIntroViewController: UIViewController {

  //MARK: IBOultlets
  @IBOutlet weak var roomCountTf: UITextField!
  @IBOutlet weak var bedCountTf: UITextField!
  @IBOutlet weak var bathCountTf: UITextField!
  @IBOutlet weak var allowedPeopleTf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

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
