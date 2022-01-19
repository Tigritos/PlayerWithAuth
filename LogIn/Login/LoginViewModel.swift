//
//  LoginViewModel.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 19.01.2022.
//

import Foundation
import UIKit
import FirebaseAuth

protocol LoginViewModelDelegate: AnyObject {
    func errorAlert(error: Error?)
    func changeRootVC()
}

final class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    
    private let userDefaults = UserDefaults.standard
    
    var email: String?
    var password: String?
    
    func getEmailUD() -> String? {
        return userDefaults.string(forKey: "email")
    }
    func getPasswordUD() -> String? {
        return userDefaults.string(forKey: "password")
    }
    
    func updateEmail(email: String?) {
        self.email = email
    }
    func updatePassword(password: String?) {
        self.password = password
    }
    
    func logInTapped() {
        guard
            let email = email,
            let password = password
        else {return}
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil{
                self.delegate?.changeRootVC()
            }
            else{
                self.delegate?.errorAlert(error: error)
            }
        }
        userDefaults.set(email, forKey: "email")
        userDefaults.set(password, forKey: "password")
    }
}
