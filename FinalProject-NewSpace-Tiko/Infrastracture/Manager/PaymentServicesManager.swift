//
//  PaymentServicesManager.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 20.07.21.
//

import UIKit

protocol PaymentServicesManagerProtocol: AnyObject {
    func fetchPaymentData(complation: @escaping (PaymentData) -> Void)
    func fetchCompaniesIds(categoryName: String, complation: @escaping ([Int]) -> Void)
    func fetchCompanies(with companiesIds: [Int], complition: @escaping ([Companies]) -> Void)
    init(with networkMangaer: NetworkManagerProtocol)
}

final class PaymentServicesManager: PaymentServicesManagerProtocol {
    
    var networkMangaer: NetworkManagerProtocol
    
    init(with networkMangaer: NetworkManagerProtocol) {
        self.networkMangaer = networkMangaer
    }
    
    func fetchPaymentData(complation: @escaping (PaymentData) -> Void) {
        let url = EndPoints.payment.rawValue
        NetworkManager.shared.get(with: url) { (result: Result<PaymentData, Error>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                complation(data)
            }
        }
    }
    
    func fetchCompaniesIds(categoryName: String, complation: @escaping ([Int]) -> Void) {
        let url = EndPoints.payment.rawValue
        NetworkManager.shared.get(with: url) { (result: Result<PaymentData, Error>) in
            switch result {
            case .success(let categories):
                for item in categories.data.categories {
                    if categoryName == item.name {
                        complation(item.companyIds ?? [])
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCompanies(with companiesIds: [Int], complition: @escaping ([Companies]) -> Void) {
        let url = EndPoints.payment.rawValue
        NetworkManager.shared.get(with: url) { (result: Result<PaymentData, Error>) in
            switch result {
            case .success(let companies):
                complition(companies.data.companies)
            case .failure(let error):
                print(error)
            }
        }
    }
}
