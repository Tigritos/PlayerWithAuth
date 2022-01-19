//
//  ProfileViewController.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 28.12.2021.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    
    private let viewModel = ProfileViewModel()
    
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        emailLabel.text = Auth.auth().currentUser?.email
        nameLabel.text = Auth.auth().currentUser?.displayName
        exitButton.tintColor = .red
    }
    
    @IBAction func exitAction(_ sender: Any) {
        viewModel.exitTapped()
    }
    
}

extension ProfileViewController: ProfileViewModelDelegate {
    func changeRootVC() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainNavVC = mainStoryboard.instantiateViewController(identifier: "MainNavigationController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainNavVC)
    }
}
