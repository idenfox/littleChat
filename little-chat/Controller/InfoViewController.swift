//
//  InfoViewController.swift
//  little-chat
//
//  Created by Renzo Paul Chamorro on 21/11/21.
//

import UIKit
import Firebase

class InfoViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var nicknameTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData()
    }
    
    private func loadUserData() {
        let docRef = db.collection(K.FStore.usersCollection).document((Auth.auth().currentUser?.email)!)
        docRef.getDocument(source: .server) { doc, _ in
            if (doc != nil) {
                self.nicknameTextfield.text = (doc!.data()!["nickname"] as! String)
            }
        }
        emailTextfield.text = Auth.auth().currentUser?.email
    }
    
    private func nicknameTextfieldIsValid() -> Bool {
        if (self.nicknameTextfield.text != nil &&
            self.nicknameTextfield.text != "" &&
            self.nicknameTextfield.text!.count > 4) {
            return true
        } else {
            return false
        }
    }
    @IBAction func updateInfoPressed(_ sender: Any) {
        view.endEditing(true)
        if (self.nicknameTextfieldIsValid()) {
            self.view.activityStartAnimating(activityColor: UIColor(named: K.BrandColors.darkGreen)!, backgroundColor: .clear)
            
            let docRef = db.collection(K.FStore.usersCollection).document((Auth.auth().currentUser?.email)!)
            docRef.setData([
                "nickname": self.nicknameTextfield.text! as String,
            ]) { err in
                if let err = err {
                    self.view.activityStopAnimating()
                    let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.nicknameTextfield.text = ""
                } else {
                    self.view.activityStopAnimating()
                    let alert = UIAlertController(title: "Listo", message: "¡Tu nickname se ha actualizado!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Tu nickname debe tener al menos 5 caracteres", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    @IBAction func logOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            let alert = UIAlertController(title: "Error", message: signOutError.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func deleteUserPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Aviso", message: "¿Estas seguro que deseas eliminar tu cuenta?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Sí, continuar", style: .destructive, handler: { action in
            let user = Auth.auth().currentUser
            user?.delete { error in
              if let error = error {
                  let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                  self.present(alert, animated: true, completion: nil)
              } else {
                  self.navigationController?.popToRootViewController(animated: true)
              }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
