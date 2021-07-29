//
//  TarsferContactViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit
import Contacts

class TarsferContactViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    // MARK: - Properties
    private var datasource: ContactDataSource!
    private var viewModel: ContactViewModelProtocol!
    private var contactManager: ContactManagerProtocol!
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureDataSource()
        dismissKeyboard()
    }
    
    private func configureDataSource() {
        contactManager = ContactManager()
        viewModel = ContactViewModel(with: navigationController, controller: self, contactManager: contactManager)
        datasource = ContactDataSource(with: self.tableView, searchTextField: searchTextField, viewModel: viewModel)
        datasource.fetchContacts()
    }
    
    private func setupLayout() {
        tableView.registerNib(class: ContactCell.self)
        searchView.cornerView(cornerRadius: 12, borderWidth: 0.3, borderColor: .lightGray)
    }
    
    @IBAction private func close(){
        viewModel.controller.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func back() {
        viewModel.controller.navigationController?.popViewController(animated: true)
    }
}
