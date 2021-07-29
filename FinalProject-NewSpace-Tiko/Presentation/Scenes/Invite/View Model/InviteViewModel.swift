//
//  InviteViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 27.07.21.
//

import Foundation

protocol InviteViewModelProtocol: AnyObject {
    var controller: CoordinatorDelegate { get }
    
    init(with controller: CoordinatorDelegate)
}

final class InviteViewModel: InviteViewModelProtocol {
    
    private(set) var controller: CoordinatorDelegate
    
    init(with controller: CoordinatorDelegate) {
        self.controller = controller
    }
}
