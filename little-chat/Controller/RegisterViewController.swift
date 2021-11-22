//
//  RegisterViewController.swift
//  little-chat
//
//  Created by Renzo Paul Chamorro on 21/11/21.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var nicknameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        nicknameTextfield.delegate = self
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
       
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            self.view.activityStartAnimating(activityColor: UIColor(named: K.BrandColors.lightGreen)!, backgroundColor: .clear)
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    self.view.activityStopAnimating()
                } else {
                    //Navigate to the ChatViewController
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                    self.view.activityStopAnimating()
                }
            }
        }
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

