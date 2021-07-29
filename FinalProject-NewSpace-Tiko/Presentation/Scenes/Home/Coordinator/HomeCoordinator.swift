//
//  HomeCoordinator.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 18.07.21.
//

import UIKit

final class HomeCoordinator: CoordinatorProtocol {
    
    var networkManager: NetworkManagerProtocol?
    var homeServiceManager: HomeServicesManagerProtocol?
    var navigationController: UINavigationController?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true

        let vc = HomeViewController.instantiateFromStoryboard()
        vc.coordinator = self
        
        vc.tabBarItem.image = UIImage(named: "ic_home")
        vc.title = "მთავარი"

        self.navigationController?.viewControllers = [vc]
        
        networkManager = NetworkManager()
        homeServiceManager = HomeServicesManager(with: networkManager!)
    }
    
    func start() {
        
    }
    
    func proceedToNewsDetailPage(with news: News) {
        let vc = NewsDetailsViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.news = news
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func proceedToInvitePage() {
        let vc = InviteViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.isNavigationBarHidden = true
        navigationController?.parent?.present(vc, animated: true)
    }
    
    func proceedToInviteDetailsPage() {
        let vc = InviteDetailsViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.isNavigationBarHidden = true
        navigationController?.present(vc, animated: true)
    }
}
