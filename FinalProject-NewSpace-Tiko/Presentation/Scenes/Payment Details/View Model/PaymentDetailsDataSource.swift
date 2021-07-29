//
//  PaymentDataSource.swift
//  Space_Project
//
//  Created by Tiko on 13.06.21.
//

import UIKit

class PaymentDetailsDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Private Properties
    private var tableView : UITableView!
    private var viewModel: PaymentDetailsViewModelProtocol!
    private var paymentCategories: [Categories] = []
    private var filterCategoriest: [Categories] = []
    private var searchTextField: UITextField!
    
    init(with tableView: UITableView, searchTextField: UITextField, viewModel: PaymentDetailsViewModelProtocol) {
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.viewModel = viewModel
        self.searchTextField = searchTextField
        self.searchTextField.delegate = self
    }
    
    func refresh() {
        self.viewModel.fetchPaymentCategories { [weak self] categories in
            self?.paymentCategories = categories.data.categories
            self?.filterCategoriest = categories.data.categories
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.filterCategoriest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(PaymentCell.self, for: indexPath)
        cell.configureCell(with: filterCategoriest[indexPath.row])
        return cell
    }
}

extension PaymentDetailsDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.controller.coordinator?.proceedToPaymentCompaniesPage(with: paymentCategories[indexPath.row].name ?? "")
    }
}

extension PaymentDetailsDataSource: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let attribute = [NSAttributedString.Key.backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ] as [NSAttributedString.Key: Any]?
        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        textField.attributedText = NSAttributedString(string: searchText, attributes: attribute)
        if searchText.count != 0 {
            self.filterCategoriest = self.paymentCategories.filter {
                ($0.name?.lowercased().contains(searchText.lowercased()))!
            }
        } else { self.filterCategoriest = self.paymentCategories }
        
        tableView.reloadData()
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}


