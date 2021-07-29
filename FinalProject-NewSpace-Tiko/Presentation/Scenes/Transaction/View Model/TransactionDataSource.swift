//
//  TransactionDataSource.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 24.07.21.
//

import UIKit

enum RefPoints: String {
    case transfers = "transfer-items"
    case payments = "payment-items"
    case users = "users"
    case userDetails = "user-items"
}

class TransactionDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Private Properties
    private var tableView: UITableView!
    private var viewModel: TransactionViewModelProtocol!
    private var searchTextField: UITextField!
    private var payments: [Transaction] = []
    private var transactions: [Transaction] = []
    private var filterTransactions: [Transaction] = []
    private var transfersByPhone: [Transaction] = []
    private var transfersByEmail: [Transaction] = []
    
    init(with tableView: UITableView, searchTextField: UITextField, viewModel: TransactionViewModelProtocol) {
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.viewModel = viewModel
        self.searchTextField = searchTextField
        self.searchTextField.delegate = self
    }
    
    func fetchPayment(with currentUser: User, refKey: String) {
        viewModel.fetchPaymentWithUser(with: currentUser, refKey: refKey) { [weak self] payments in
            guard let self = self else { return }
            self.payments = payments.map { Transaction (name: $0.name,
                                                        amount: $0.amount,
                                                        phone: "",
                                                        time: $0.time,
                                                        companyName: $0.name,
                                                        addedByUser: $0.addedByUser,
                                                        recieverId: "",
                                                        senderId: "",
                                                        color: "red",
                                                        balance: "")}
            self.transactions = self.payments + self.transfersByPhone + self.transfersByEmail
            self.filterTransactions = self.payments + self.transfersByPhone + self.transfersByEmail
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchTransferEntered(with currentUser: User, refKey: String) {
        viewModel.fetchPhoneNumberByUser(with: currentUser, refKey: refKey) { [weak self] phone in
            guard let self = self else { return }
            self.viewModel.fetchTransferByPhone(with: phone, refKey: RefPoints.transfers.rawValue) { [weak self] tranfers in
                guard let self = self else { return }
                self.transfersByPhone = tranfers.map { Transaction (name: $0.name,
                                                                    amount: $0.amount,
                                                                    phone: $0.recieverId,
                                                                    time: $0.time,
                                                                    companyName: "",
                                                                    addedByUser: "",
                                                                    recieverId: $0.recieverId,
                                                                    senderId: $0.senderId,
                                                                    color: "green",
                                                                    balance: "")}
                self.transactions = self.payments + self.transfersByPhone + self.transfersByEmail
                self.filterTransactions = self.payments + self.transfersByPhone + self.transfersByEmail
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func fetchTransferPassed(with currentUser: User, refKey: String) {
        viewModel.fetchTransferByEmail(with: currentUser, refKey: RefPoints.transfers.rawValue) { [weak self] tranfers in
            guard let self = self else { return }
            self.transfersByEmail = tranfers.map { Transaction (name: $0.name,
                                                                amount: $0.amount,
                                                                phone: $0.recieverId,
                                                                time: $0.time,
                                                                companyName: "",
                                                                addedByUser: "",
                                                                recieverId: $0.recieverId,
                                                                senderId: $0.senderId,
                                                                color: "blue",
                                                                balance: "")}
            self.transactions = self.payments + self.transfersByPhone + self.transfersByEmail
            self.filterTransactions = self.payments + self.transfersByPhone + self.transfersByEmail
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(TransactionCell.self, for: indexPath)
        cell.configure(with: filterTransactions[indexPath.row])
        return cell
    }
}

extension TransactionDataSource: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let attribute = [NSAttributedString.Key.backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ] as [NSAttributedString.Key: Any]?
        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        textField.attributedText = NSAttributedString(string: searchText, attributes: attribute)
        if searchText.count != 0 {
            filterTransactions = transactions.filter {
                ($0.name?.lowercased().contains(searchText.lowercased()))!
            }
        } else { filterTransactions = transactions }
        
        tableView.reloadData()
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}
