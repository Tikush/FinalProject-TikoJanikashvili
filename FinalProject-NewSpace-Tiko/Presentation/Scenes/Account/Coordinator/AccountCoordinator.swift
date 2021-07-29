//
//  AccountCoordinator.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 26.07.21.
//

import UIKit

final class AccountCoordinator: CoordinatorProtocol {

    var navigationController: UINavigationController?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true

        let vc = AccountViewController.instantiateFromStoryboard()
        vc.coordinator = self
        
        vc.tabBarItem.image = UIImage(named: "ic_account")
        vc.title = "ანგარიში"

        self.navigationController?.viewControllers = [vc]
    }
    
    func start() {
        
    }
    
    func proceedToWelcomePage() {
        let vc = WelcomeViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.isNavigationBarHidden = true
        navigationController?.parent?.navigationController?.setViewControllers([vc], animated: true)
    }
}
