//
//  RegistrationViewController.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 26.12.2021.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {
    

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rePassword: UITextField!
    
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.placeholder = "name"
        email.placeholder = "email"
        password.placeholder = "password"
        rePassword.placeholder = "confirm password"
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        
        if password.text != rePassword.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            guard
                let name = name.text,
                let email = email.text,
                let password = password.text
            else {return}
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "SignUp", sender: self)
                    
                   
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            userDefaults.set(name, forKey: "name")
        }
    }
    

}
