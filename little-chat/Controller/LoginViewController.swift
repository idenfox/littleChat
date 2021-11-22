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
    
    private func textfieldErrorDataInput() -> String? {
        if (emailTextfield.text == nil ||
            passwordTextfield.text == nil ||
            emailTextfield.text == "" ||
            passwordTextfield.text == "") {
            return "Por favor ingrese sus datos"
        } else {
            return nil
        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        let errorTextField = self.textfieldErrorDataInput()
        if (errorTextField == nil) {
            self.view.activityStartAnimating(activityColor: UIColor(named: K.BrandColors.lightGreen)!, backgroundColor: .clear)
            Auth.auth().signIn(withEmail: self.emailTextfield.text!, password: self.passwordTextfield.text!) { authResult, error in
                if (error == nil) {
                    self.view.activityStopAnimating()
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                } else {
                    self.view.activityStopAnimating()
                    let alert = UIAlertController(title: "Error de servicio", message: error!.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error de validación", message: errorTextField!, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

