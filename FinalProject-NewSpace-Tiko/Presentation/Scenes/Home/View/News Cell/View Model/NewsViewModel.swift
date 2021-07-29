//
//  CoverViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit

protocol NewsViewModelProtocol: AnyObject {
    var coordinator: CoordinatorProtocol { get }
    
    init(with coordinator: CoordinatorProtocol)
}

final class NewsViewModel: NewsViewModelProtocol {
    
    private(set) var coordinator: CoordinatorProtocol
  
    init(with coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
