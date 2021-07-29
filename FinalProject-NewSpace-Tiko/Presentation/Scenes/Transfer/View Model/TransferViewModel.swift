//
//  TransferViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import Foundation

protocol TransferViewModelProtocol: AnyObject {
    var controller: CoordinatorDelegate { get }
    
    init(with controller: CoordinatorDelegate)
}

final class TransferViewModel: TransferViewModelProtocol {
    
    private(set) var controller: CoordinatorDelegate
    
    init(with controller: CoordinatorDelegate) {
        self.controller = controller
    }
}
