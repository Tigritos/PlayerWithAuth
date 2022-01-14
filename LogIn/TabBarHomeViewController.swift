//
//  TabBarHomeViewController.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 27.12.2021.
//

import UIKit

class TabBarHomeViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let homeStoryboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let profileStoryboard = UIStoryboard(name: "ProfileStoryboard", bundle: nil)
        
        guard
            let itemHome = homeStoryboard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController,
            let itemProfile = profileStoryboard.instantiateViewController(identifier: "ProfileViewController") as? ProfileViewController
        else { return }
        let iconHome = UITabBarItem(title: "Home", image: UIImage(systemName: "homekit"), selectedImage: UIImage(systemName: "homekit"))
        let iconProfile = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        
        itemHome.tabBarItem = iconHome
        itemProfile.tabBarItem = iconProfile
        let controllers = [itemHome, itemProfile]
        self.viewControllers = controllers
    }
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        print("Should select viewController: \(viewController.title ?? "") ?")
//        return true;
//    }
}
