//
//  ProfileViewModel.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 19.01.2022.
//

import Foundation
import UIKit
import FirebaseAuth

protocol ProfileViewModelDelegate: AnyObject {
    func changeRootVC()
}

final class ProfileViewModel {
    
    weak var delegate: ProfileViewModelDelegate?
    
    private let userDefaults = UserDefaults.standard
    
    func exitTapped() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error sign out: \(signOutError)")
        }
        delegate?.changeRootVC()
        userDefaults.removeObject(forKey: "email")
        userDefaults.removeObject(forKey: "password")
    }
}
