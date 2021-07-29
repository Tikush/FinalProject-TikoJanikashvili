//
//  ContactDataSource.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit
import Contacts

class ContactDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Private Properties
    private var tableView: UITableView!
    private var viewModel: ContactViewModelProtocol!
    private var searchTextField: UITextField!
    private var contacts: [Contact] = []
    private var slide: SliderForContactProtocol!
    private var filterContacts: [Contact] = []
    
    init(with tableView: UITableView, searchTextField: UITextField, viewModel: ContactViewModelProtocol) {
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.viewModel = viewModel
        self.searchTextField = searchTextField
        self.searchTextField.delegate = self
        self.slide = SliderForContact(with: viewModel.controller)
    }
    
    func fetchContacts() {
        viewModel.fetchContacts { [weak self] contacts in
            self?.filterContacts = contacts
            self?.contacts = contacts
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.filterContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(ContactCell.self, for: indexPath)
        cell.configure(with: self.filterContacts[indexPath.row])
        return cell
    }
}

extension ContactDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = filterContacts[indexPath.row]
        if contact.numbers.count > 1 {
            slide.loadSlide(contact: filterContacts[indexPath.row])
        } else {
            viewModel
                .controller
                .coordinator?
                .proceedToTransferMoneyPage(number: filterContacts[indexPath.row].number ?? "", name: filterContacts[indexPath.row].name, symbol: filterContacts[indexPath.row].symbol )
        }
    }
}

extension ContactDataSource: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let attribute = [NSAttributedString.Key.backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ] as [NSAttributedString.Key: Any]?
        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        textField.attributedText = NSAttributedString(string: searchText, attributes: attribute)
        if searchText.count != 0 {
            self.filterContacts = self.contacts.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                    $0.lastName.lowercased().contains(searchText.lowercased()) 
            }
        } else { self.filterContacts = self.contacts }
        
        tableView.reloadData()
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}

