//
//  LoginViewController.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 26.12.2021.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        email.placeholder = "example@mail.com"
        password.placeholder = "password"
        email.delegate = self
        password.delegate = self
        email.text = viewModel.getEmailUD()
        password.text = viewModel.getPasswordUD()
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == email {
            viewModel.updateEmail(email: email.text)
        }else if textField == password {
            viewModel.updatePassword(password: password.text)
        }
    }
    
    @IBAction func logInAction(_ sender: Any) {
        viewModel.logInTapped()
    }
    
}

extension LoginViewController: LoginViewModelDelegate {
    
    func changeRootVC() {
        let storyboard = UIStoryboard(name: "TabBarStoryboard", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "TabBarHomeViewController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
    
    func errorAlert(error: Error?) {
        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
