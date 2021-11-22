//
//  LoginViewController.swift
//  little-chat
//
//  Created by Renzo Paul Chamorro on 21/11/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        self.view.activityStartAnimating(activityColor: UIColor(named: K.BrandColors.lightGreen)!, backgroundColor: .clear)
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    self.view.activityStopAnimating()
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                    self.view.activityStopAnimating()
                }
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

