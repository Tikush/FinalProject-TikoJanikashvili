//
//  CardViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit

protocol CardViewModelProtocol: AnyObject {
    var coordinator: CoordinatorProtocol { get }
    
    init(with coordinator: CoordinatorProtocol)
}

final class CardViewModel: CardViewModelProtocol {
    
    private(set) var coordinator: CoordinatorProtocol
  
    init(with coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
