//
//  MainTabBarViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 19.07.21.
//

import UIKit

class MainTabBarViewController: UITabBarController, Storyboarded, CoordinatorDelegate {
    
    // MARK: - Private Properties
    private var homeCoordinator = HomeCoordinator()
    private var accountCoordinator = AccountCoordinator()
    private var transactionCoordinator = TransactionCoordinator()
    private var transferCoordinator = TransferCoordinator()
    private var paymentCoordinator = PaymentCoordinator()
    
    var coordinator: CoordinatorProtocol?
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            homeCoordinator.navigationController!,
            accountCoordinator.navigationController!,
            transactionCoordinator.navigationController!,
            transferCoordinator.navigationController!,
            paymentCoordinator.navigationController!
        ]
        
        setupTabBarColor()
    }
    
    private func setupTabBarColor() {
        self.tabBar.tintColor = Constants.Color.brandBlue
        self.tabBar.layer.borderWidth = 0.3
        self.tabBar.layer.borderColor = Constants.Color.disabledGrey.cgColor
        self.tabBar.clipsToBounds = true
    }
}
