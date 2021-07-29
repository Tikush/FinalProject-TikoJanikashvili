//
//  CompanyDetailsViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 21.07.21.
//

import Foundation

protocol CompanyDetailsViewModelProtocol: AnyObject {
    
    var controller: CoordinatorDelegate { get }
    
    init(with controller: CoordinatorDelegate)
}

final class CompanyDetailsViewModel: CompanyDetailsViewModelProtocol {
    
    private(set) var controller: CoordinatorDelegate
    
    init(with controller: CoordinatorDelegate) {
        self.controller = controller
    }
}
