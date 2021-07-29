//
//  AppCoordinator.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 16.07.21.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    // MARK: - Private properties
    private var window: UIWindow?
    private var navigationController: UINavigationController?
    
    // MARK: - Init
    init(_ window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
    }
    
    // MARK: - Functions
    func start() {
        let vc = WelcomeViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func login(with controller: UIViewController) {
        let vc = LoginViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.modalPresentationStyle = .overFullScreen
        controller.present(vc, animated: true)
    }
    
    func register(with controller: UIViewController) {
        let vc = RegisterViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.modalPresentationStyle = .overFullScreen
        controller.present(vc, animated: true)
    }
    
    func main() {
        let vc = MainTabBarViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
        navigationController?.isNavigationBarHidden = true
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
