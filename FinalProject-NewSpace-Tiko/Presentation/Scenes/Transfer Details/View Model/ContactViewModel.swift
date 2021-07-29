//
//  ContactViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit
import Contacts

protocol ContactViewModelProtocol: AnyObject {
    func fetchContacts(complition: @escaping([Contact]) -> Void)
    init(with navigationController: UINavigationController?, controller: CoordinatorDelegate, contactManager: ContactManagerProtocol)
    
    var controller: CoordinatorDelegate { get }
}

final class ContactViewModel: ContactViewModelProtocol {
    
    var controller: CoordinatorDelegate
    
    // MARK: - Private Properties
    private var navigationController: UINavigationController?
    private var contactManager: ContactManagerProtocol!
    
    init(with navigationController: UINavigationController?, controller: CoordinatorDelegate, contactManager: ContactManagerProtocol) {
        self.navigationController = navigationController
        self.controller = controller
        self.contactManager = contactManager
    }
    
    func fetchContacts(complition: @escaping ([Contact]) -> Void) {
        contactManager.fetchContacts(complition: complition)
    }
}
