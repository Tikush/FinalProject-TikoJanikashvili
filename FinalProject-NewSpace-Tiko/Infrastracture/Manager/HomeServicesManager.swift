//
//  HomeServicesManager.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import Foundation

protocol HomeServicesManagerProtocol: AnyObject {
    func fetchHomeData()
    func fetchProductDetails(with productId: String)
    
    func fetchNews(completion: @escaping ((Result<[News], Error>) -> Void))
    init(with networkMangaer: NetworkManagerProtocol)
}

final class HomeServicesManager: HomeServicesManagerProtocol {
    
    private let newtorkManger: NetworkManagerProtocol
    
    init(with networkMangaer: NetworkManagerProtocol) {
        self.newtorkManger = networkMangaer
    }
    
    func fetchNews(completion: @escaping ((Result<[News], Error>) -> Void)) {
        let url = EndPoints.news.rawValue
        
        NetworkManager.shared.get(with: url) { (result: Result<[News], Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
     
    func fetchHomeData() {
        print("Fetching home data...")
    }
    
    func fetchProductDetails(with productId: String) {}
}
