//
//  TransferMoneyViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 23.07.21.
//

import Foundation

protocol TransferMoneyViewModelProtocol: AnyObject {
    var controller: CoordinatorDelegate { get }
    
    init(with controller: CoordinatorDelegate)
}

final class TransferMoneyViewModel: TransferMoneyViewModelProtocol {
    
    private(set) var controller: CoordinatorDelegate
    
    init(with controller: CoordinatorDelegate) {
        self.controller = controller
    }
}
