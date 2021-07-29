//
//  TransactionCoordinator.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 24.07.21.
//

import UIKit

final class TransactionCoordinator: CoordinatorProtocol {
    
    var networkManager: NetworkManagerProtocol?
    var navigationController: UINavigationController?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true

        let vc = TransactionViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.tabBarItem.image = UIImage(named: "ic_transaction")
        vc.title = "ტრანზაქციები"

        self.navigationController?.viewControllers = [vc]
        
        networkManager = NetworkManager()
    }
    
    func start() {
        
    }
}

