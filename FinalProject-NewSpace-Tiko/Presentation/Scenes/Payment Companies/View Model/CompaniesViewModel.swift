//
//  CompaniesViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 20.07.21.
//

import UIKit

protocol CompaniesViewModelProtocol: AnyObject {
    func fetchCompaniesIds()
    func fetchCompanies(complition: @escaping ([Companies]) -> Void)
    init(with paymentManager: PaymentServicesManagerProtocol, navigationController: UINavigationController?, controller: CoordinatorDelegate, categoryName: String)
    
    var didFinishedLoading: (() -> Void)? { get set }
    var controller: CoordinatorDelegate { get }
}

final class CompaniesViewModel: CompaniesViewModelProtocol {
    
    var controller: CoordinatorDelegate
    
    // MARK: - Private Properties
    private var paymentManager: PaymentServicesManagerProtocol
    private var navigationController: UINavigationController?
    private var companiesIds: [Int] = []
    var didFinishedLoading: (() -> Void)?
    var categoryName: String
    
    init(with paymentManager: PaymentServicesManagerProtocol, navigationController: UINavigationController?, controller: CoordinatorDelegate, categoryName: String) {
        self.paymentManager = paymentManager
        self.navigationController = navigationController
        self.controller = controller
        self.categoryName = categoryName
    }
    
    func fetchCompaniesIds() {
        paymentManager.fetchCompaniesIds(categoryName: categoryName) { companiesIds in
            self.companiesIds = companiesIds
        }
    }
    
    func fetchCompanies(complition: @escaping ([Companies]) -> Void) {
        paymentManager.fetchCompanies(with: companiesIds) { [weak self] companies in
            guard let self = self else { return }
            
            var companiesList: [Companies] = []
            for company in companies {
                for companyId in self.companiesIds {
                    if company.companyId == companyId {
                        companiesList.append(company)
                    }
                }
            }
            
            complition(companiesList)
            self.didFinishedLoading?()
        }
    }
}
