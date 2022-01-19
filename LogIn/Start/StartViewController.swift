//
//  ViewController.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 26.12.2021.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginAction(_ sender: Any) {
        let loginStoryboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        guard
            let loginVC = loginStoryboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
        else { return }
        navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
    @IBAction func registrationAction(_ sender: Any) {
        let registrationStoryboard = UIStoryboard(name: "RegistrationStoryboard", bundle: nil)
        guard
            let registrationVC = registrationStoryboard.instantiateViewController(identifier: "RegistrationViewController") as? RegistrationViewController
        else { return }
        navigationController?.pushViewController(registrationVC, animated: true)
        
    }
    
}

