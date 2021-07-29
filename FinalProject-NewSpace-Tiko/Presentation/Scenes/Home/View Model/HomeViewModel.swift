//
//  HomeViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    
    func fetchNews(completion: @escaping((Result<[News], Error>) -> Void))
    
    var controller: CoordinatorDelegate { get }
    init(with controller: CoordinatorDelegate)
}

final class HomeViewModel: HomeViewModelProtocol {
    
    private(set) var controller: CoordinatorDelegate
    
    init(with controller: CoordinatorDelegate) {
        self.controller = controller
    }
    
    func fetchNews(completion: @escaping((Result<[News], Error>) -> Void)) {
        controller.coordinator?.homeServiceManager?.fetchNews(completion: completion)
    }
}


