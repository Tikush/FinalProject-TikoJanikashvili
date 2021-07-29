//
//  TransactionViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 24.07.21.
//

import UIKit
import Firebase

class TransactionViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableIView: UITableView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchView: UIView!
    
    // MARK: - Private Properties
    private var viewModel: TransactionViewModelProtocol!
    private var datasource: TransactionDataSource!
    private var currenrUser: User!
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureViewModel()
        dismissKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        datasource.fetchPayment(with: currenrUser, refKey: RefPoints.payments.rawValue)
        datasource.fetchTransferEntered(with: currenrUser, refKey: RefPoints.users.rawValue)
        datasource.fetchTransferPassed(with: currenrUser, refKey: RefPoints.users.rawValue)
    }
    
    private func setupLayout() {
        tableIView.registerNib(class: TransactionCell.self)
        searchView.cornerView(cornerRadius: 12, borderWidth: 0.3, borderColor: .lightGray)
    }
    
    private func configureViewModel() {
        let user = Auth.auth().currentUser
        if let user = user {
            currenrUser = User(uid: user.uid, email: user.email ?? "", phone: user.phoneNumber ?? "")
        }
        viewModel = TransactionViewModel(with: navigationController, controller: self)
        datasource = TransactionDataSource(with: tableIView, searchTextField: searchTextField, viewModel: viewModel)
        datasource.fetchPayment(with: currenrUser, refKey: RefPoints.payments.rawValue)
        datasource.fetchTransferEntered(with: currenrUser, refKey: RefPoints.users.rawValue)
        datasource.fetchTransferPassed(with: currenrUser, refKey: RefPoints.users.rawValue)
    }
}
