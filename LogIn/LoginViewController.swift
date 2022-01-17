//
//  LoginViewController.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 26.12.2021.
//

import UIKit
import FirebaseAuth

class Singleton {
    
    public static let shared = Singleton()
    private init() { }
    
}

    class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.placeholder = "email"
        password.placeholder = "password"
        email.text = userDefaults.string(forKey: "email")
        password.text = userDefaults.string(forKey: "password")
    }
    
    @IBAction func logInAction(_ sender: Any) {
        guard
            let email = email.text,
            let password = password.text
        else {return}
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil{
                let storyboard = UIStoryboard(name: "TabBarStoryboard", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "TabBarHomeViewController")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        userDefaults.set(email, forKey: "email")
        userDefaults.set(password, forKey: "password")
    }
    
    
}
