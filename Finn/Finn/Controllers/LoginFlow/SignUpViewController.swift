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
    @IBOutlet weak var keyboardMargin: NSLayoutConstraint!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBAction func removeKeyboard(_ sender: Any) {
        firstNameTF.resignFirstResponder()
        lastNameTF.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTF.borderBottom(height: 1.0, color: UIColor.white)
        lastNameTF.borderBottom(height: 1.0, color: UIColor.white)
        btnCustom()
        addKeyboardObserver()
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
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: .main) {
            [weak self] in
            guard let userInfo = $0.userInfo,
                let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
                let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
                let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt
                else { return }
            
            UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: curve), animations: {
                self?.keyboardMargin.constant = keyboardFrame.height + 30
                self?.view.layoutIfNeeded()
            })
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: .main) {
            [weak self] in
            guard let userInfo = $0.userInfo,
                let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
                let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
                let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt
                else { return }
            
            UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: curve), animations: {
                self?.keyboardMargin.constant = 20
                self?.view.layoutIfNeeded()
            })
        }
    }
    
    private func btnCustom() {
        nextBtn.backgroundColor = .white
//        nextBtn.layer.cornerRadius = self.view.frame.width / 2.0
    }
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
