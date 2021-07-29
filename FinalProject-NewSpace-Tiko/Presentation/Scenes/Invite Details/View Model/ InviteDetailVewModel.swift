//
//   InviteDetailVewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 28.07.21.
//

import UIKit

protocol InviteDetailVewModelProtocol: AnyObject {
    func fetchContacts(complition: @escaping ([Contact]) -> Void)
    
    var controller: CoordinatorDelegate { get }
    init(with controller: CoordinatorDelegate, contactManager: ContactManagerProtocol)
}

final class InviteDetailVewModel: InviteDetailVewModelProtocol {
    
    private(set) var controller: CoordinatorDelegate
    private var contactManager: ContactManagerProtocol
    
    init(with controller: CoordinatorDelegate, contactManager: ContactManagerProtocol) {
        self.controller = controller
        self.contactManager = contactManager
    }
    
    func fetchContacts(complition: @escaping ([Contact]) -> Void) {
        contactManager.fetchContacts(complition: complition)
    }
}
