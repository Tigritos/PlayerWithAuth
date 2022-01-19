//
//  RegistrationViewController.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 26.12.2021.
//

import Foundation
import UIKit
import FirebaseAuth
import CoreMIDI

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rePassword: UITextField!
    
    private let viewModel = RegistrationViewModel()
    
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        name.placeholder = "name"
        email.placeholder = "example@mail.com"
        password.placeholder = "password"
        rePassword.placeholder = "confirm password"
        name.delegate = self
        email.delegate = self
        password.delegate = self
        rePassword.delegate = self
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == name {
            viewModel.updateName(name: name.text)
        } else if textField == email {
            viewModel.updateEmail(email: email.text)
        }else if textField == password {
            viewModel.updatePassword(password: password.text)
        }else if textField == rePassword {
            viewModel.updateRePassword(rePassword: rePassword.text)
        }
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        viewModel.signUpTapped()
    }
    
}
extension RegistrationViewController: RegistrationViewModelDelegate {
    func incorrectPasswordAlert() {
        let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func errorAlert(error: Error?) {
        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func changeRootVC() {
        let storyboard = UIStoryboard(name: "TabBarStoryboard", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "TabBarHomeViewController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
}
