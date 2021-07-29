//
//  PaymentsListViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit

protocol PaymentDetailsViewModelProtocol: AnyObject {
    func fetchPaymentCategories(complition: @escaping(PaymentData) -> Void)
    init(with paymentManager: PaymentServicesManagerProtocol, navigationController: UINavigationController?, controller: CoordinatorDelegate)
    var didFinishedLoading: (() -> Void)? { get set }
    
    var controller: CoordinatorDelegate { get }
}

final class PaymentDetailsViewModel: PaymentDetailsViewModelProtocol {
    
    var controller: CoordinatorDelegate
    
    // MARK: - Private Properties
    private var paymentManager: PaymentServicesManagerProtocol
    private var navigationController: UINavigationController?
    var didFinishedLoading: (() -> Void)?
    
    init(with paymentManager: PaymentServicesManagerProtocol, navigationController: UINavigationController?, controller: CoordinatorDelegate) {
        self.paymentManager = paymentManager
        self.navigationController = navigationController
        self.controller = controller
    }
    
    func fetchPaymentCategories(complition: @escaping (PaymentData) -> Void) {
        self.paymentManager.fetchPaymentData { paymants in
            complition(paymants)
            self.didFinishedLoading?()
        }
    }
}
