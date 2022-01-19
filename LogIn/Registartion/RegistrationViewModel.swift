//
//  RegistrationViewModel.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 18.01.2022.
//

import Foundation
import UIKit
import FirebaseAuth
import CoreMIDI

protocol RegistrationViewModelDelegate: AnyObject {
    func incorrectPasswordAlert()
    func errorAlert(error: Error?)
    func changeRootVC()
}

final class RegistrationViewModel {
    
    weak var delegate: RegistrationViewModelDelegate?
    
    var name: String? 
    var email: String?
    var password: String?
    var rePassword: String?
    
    func updateName(name: String?) {
        self.name = name
    }
    func updateEmail(email: String?) {
        self.email = email
    }
    func updatePassword(password: String?) {
        self.password = password
    }
    func updateRePassword(rePassword: String?) {
        self.rePassword = rePassword
    }
    
    func signUpTapped() {
        if password != rePassword {
            delegate?.incorrectPasswordAlert()
        } else {
            guard
                let name = name,
                let email = email,
                let password = password
            else {return}
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    self.delegate?.changeRootVC()
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = name
                    changeRequest?.commitChanges { error in
                        if error == nil {
                            print("name updated")
                        } else {
                            print("Error")
                        }
                    }
                } else {
                    self.delegate?.errorAlert(error: error)
                }
            }
        }
    }
    
}
