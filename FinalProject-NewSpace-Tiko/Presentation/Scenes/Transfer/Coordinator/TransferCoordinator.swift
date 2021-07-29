//
//  TransferCoordinator.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 18.07.21.
//

import UIKit

final class TransferCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var transferServiceManager: TransferServicesManagerProtocol?
    var networkManager: NetworkManagerProtocol?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true

        let vc = TransferViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.tabBarItem.image = UIImage(named: "ic_transfer")
        vc.title = "გადარიცხვა"

        self.navigationController?.viewControllers = [vc]
        
        networkManager = NetworkManager()
        transferServiceManager = TransferServicesManager(with: networkManager!)
    }
    
    func start() {
    
    }
    
    func proceedToTransferDerailsPage() {
        let vc = TarsferContactViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func proceedToTransferMoneyPage(number: String, name: String, symbol: String) {
        let vc = TransferMoneyViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.name = name
        vc.symbol = symbol
        vc.number = number
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func proceedToTransferGifPage(number: String, name: String, symbol: String, money: String) {
        let vc = TransferGifViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.money = money
        vc.name = name
        vc.number = number
        vc.symbol = symbol
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func proceedToTransferPayPage() {
        let vc = TransferPayViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
