//
//  InviteDetailsViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 27.07.21.
//

import UIKit

class InviteDetailsViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    // MARK: - Private Properties
    private var viewModel: InviteDetailVewModelProtocol!
    private var contactManager: ContactManagerProtocol!
    private var datasource: InviteDetailDataSource!
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureViewModel()
        dismissKeyboard()
    }
    
    private func setupLayout() {
        tableView.registerNib(class: InviteContactCell.self)
        searchView.cornerView(cornerRadius: 12, borderWidth: 0.3, borderColor: .lightGray)
    }
    
    private func configureViewModel() {
        contactManager = ContactManager()
        viewModel = InviteDetailVewModel(with: self, contactManager: contactManager)
        datasource = InviteDetailDataSource(with: tableView, searchTextField: searchTextField, viewModel: viewModel)
        datasource.refresh()
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
}
