//
//  CompaniesDataSource.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 20.07.21.
//

import UIKit

class CompaniesDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Private Properties
    private var tableView : UITableView!
    private var viewModel: CompaniesViewModelProtocol!
    private var companies: [Companies] = []
    private var filterCompanies: [Companies] = []
    private var searchTextField: UITextField!
    
    init(with tableView: UITableView, searchTextField: UITextField!, viewModel: CompaniesViewModelProtocol) {
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.viewModel = viewModel
        self.searchTextField = searchTextField
        self.searchTextField.delegate = self
    }
    
    func refresh() {
        viewModel.fetchCompaniesIds()
        viewModel.fetchCompanies { [weak self] companies in
            guard let self = self else { return }
            self.companies = companies
            self.filterCompanies = companies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterCompanies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(CompanyCell.self, for: indexPath)
        cell.configure(with: filterCompanies[indexPath.row])
        return cell
    }
}

extension CompaniesDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.controller.coordinator?.proceedToCompaniesDetailsPage(with: companies[indexPath.row].name ?? "", companyImage: companies[indexPath.row].picture ?? "")
            
    }
}

extension CompaniesDataSource: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let attribute = [NSAttributedString.Key.backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ] as [NSAttributedString.Key: Any]?
        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        textField.attributedText = NSAttributedString(string: searchText, attributes: attribute)
        if searchText.count != 0 {
            self.filterCompanies = companies.filter {
                ($0.name?.lowercased().contains(searchText.lowercased()))!
            }
        } else { self.filterCompanies = companies }
        
        tableView.reloadData()
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.becomeFirstResponder()
        return false
    }
}

