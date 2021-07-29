//
//  CoordinatorProtocol.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 16.07.21.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    
    var networkManager: NetworkManagerProtocol? { get }
    var paymentServicesManager: PaymentServicesManagerProtocol? { get }
    var homeServiceManager: HomeServicesManagerProtocol? { get }
    
    init(_ window: UIWindow?, navigationController: UINavigationController?)
    
    func start()
    func login(with controller: UIViewController)
    func register(with controller: UIViewController)
    func main()
    func proceedToPaymentDetailsPage()
    func proceedToPaymentCompaniesPage(with categoryName: String)
    func proceedToCompaniesDetailsPage(with companyName: String, companyImage: String)
    func proceedToPayDetailsPage(with companyName: String, companyImage: UIImage, account: String)
    func proceedToPaySuccessPage()
    
    func proceedToTransferDerailsPage()
    func proceedToTransferMoneyPage(number: String, name: String, symbol: String)
    func proceedToTransferGifPage(number: String, name: String, symbol: String, money: String)
    func proceedToTransferPayPage()
    
    func proceedToNewsDetailPage(with news: News)
    func proceedToWelcomePage()
    func proceedToInvitePage()
    func proceedToInviteDetailsPage()
}

extension CoordinatorProtocol {
    var networkManager: NetworkManagerProtocol? {
        set { print("") }
        get { nil }
    }
    
    var paymentServicesManager: PaymentServicesManagerProtocol? {
        set { print("") }
        get { nil }
    }
    
    var homeServiceManager: HomeServicesManagerProtocol? {
        set { print("") }
        get { nil }
    }
    
    func login(with controller: UIViewController) {}
    func register(with controller: UIViewController) {}
    func main() {}
    func proceedToPaymentDetailsPage() {}
    func proceedToPaymentCompaniesPage(with categoryId: String) {}
    func proceedToCompaniesDetailsPage(with companyName: String, companyImage: String) {}
    func proceedToPayDetailsPage(with companyName: String, companyImage: UIImage, account: String) {}
    func proceedToPaySuccessPage() {}
    
    func proceedToTransferDerailsPage() {}
    func proceedToTransferMoneyPage(number: String, name: String, symbol: String) {}
    func proceedToTransferGifPage(number: String, name: String, symbol: String, money: String) {}
    func proceedToTransferPayPage() {}
    
    func proceedToNewsDetailPage(with news: News) {}
    func proceedToWelcomePage() {}
    func proceedToInvitePage() {}
    func proceedToInviteDetailsPage() {}
}
