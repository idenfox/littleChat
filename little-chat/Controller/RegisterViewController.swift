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
    
    @IBAction func registerPressed(_ sender: UIButton) {
       
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            self.view.activityStartAnimating(activityColor: UIColor(named: "LightPrimaryColor")!, backgroundColor: .clear)
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    self.view.activityStopAnimating()
                } else {
                    //Navigate to the ChatViewController
//                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                    print("RENZOPR FIREBASE: USUARIO CREADO CON EXITO")
                    self.view.activityStopAnimating()
                }
            }
        }
    }
    
}

