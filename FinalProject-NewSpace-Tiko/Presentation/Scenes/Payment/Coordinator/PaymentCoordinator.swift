//
//  PaymentCoordinator.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 18.07.21.
//

import UIKit

final class PaymentCoordinator: CoordinatorProtocol {
    
    // MARK: - Internal Properties
    var networkManager: NetworkManagerProtocol?
    var navigationController: UINavigationController?
    var paymentServiceManager: PaymentServicesManagerProtocol?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true

        let vc = PaymentViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.tabBarItem.image = UIImage(named: "ic_payment")
        vc.title = "გადახდა"

        self.navigationController?.viewControllers = [vc]
        
        networkManager = NetworkManager()
        paymentServiceManager = PaymentServicesManager(with: networkManager!)
    }
    
    func start() {
        
    }
    
    func proceedToPaymentDetailsPage() {
        let vc = PaymentDetailsViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func proceedToPaymentCompaniesPage(with categoryName: String) {
        let vc = PaymentCompaniesViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.categoryName = categoryName
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func proceedToCompaniesDetailsPage(with companyName: String, companyImage: String) {
        let vc = CompanyDetailsViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.image = companyImage
        vc.name = companyName
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func proceedToPayDetailsPage(with companyName: String, companyImage: UIImage, account: String) {
        let vc = PayDetailsViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.image = companyImage
        vc.name = companyName
        vc.account = account
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func proceedToPaySuccessPage() {
        let vc = PaySuccessViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
