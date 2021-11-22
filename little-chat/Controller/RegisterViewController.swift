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
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        nicknameTextfield.delegate = self
    }
    
    private func textfieldErrorDataInput() -> String? {
        if (emailTextfield.text == nil ||
            passwordTextfield.text == nil ||
            nicknameTextfield.text == nil ||
            emailTextfield.text == "" ||
            passwordTextfield.text == "" ||
            nicknameTextfield.text == "") {
            return "Por favor ingrese sus datos"
        } else if (emailTextfield.text!.count < 5 ||
                   passwordTextfield.text!.count < 5 ||
                   nicknameTextfield.text!.count < 3) {
            return "Tu correo y contraseña deben de tener al menos 5 carácteres y tu nickname al menos 3."
        } else {
            return nil
        }
    }
    
    private func saveAditionaldata(userEmail: String, nickname: String) {
        self.db.collection("users").document(userEmail).setData([
            "nickname": nickname
        ]) { err in
            if let err = err {
                let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: K.registerSegue, sender: self)
            }
        }
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        let errorTextField = self.textfieldErrorDataInput()
        if (errorTextField == nil) {
            self.view.activityStartAnimating(activityColor: UIColor(named: K.BrandColors.darkGreen)!, backgroundColor: .clear)
            Auth.auth().createUser(withEmail: self.emailTextfield.text!, password: self.passwordTextfield.text!) { authResult, error in
                if (error == nil) {
                    let userEmail = authResult?.user.email
                    self.view.activityStopAnimating()
                    self.saveAditionaldata(userEmail: userEmail!, nickname: self.nicknameTextfield.text!)
                } else {
                    self.view.activityStopAnimating()
                    let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "¡Verifica tus datos!", message: errorTextField!, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

