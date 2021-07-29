//
//   InviteDetailDataSource.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 28.07.21.
//

import UIKit
import MessageUI

class InviteDetailDataSource: NSObject, UITableViewDataSource, MFMessageComposeViewControllerDelegate {
  
    // MARK: - Private Properties
    private var tableView: UITableView!
    private var viewModel: InviteDetailVewModelProtocol!
    private var searchTextField: UITextField!
    private var contacts: [Contact] = []
    private var filterContacts: [Contact] = []
    
    init(with tableView: UITableView, searchTextField: UITextField, viewModel: InviteDetailVewModelProtocol) {
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.viewModel = viewModel
        self.searchTextField = searchTextField
        self.searchTextField.delegate = self
    }
    
    func refresh() {
        viewModel.fetchContacts { [weak self] contacts in
            self?.filterContacts = contacts
            self?.contacts = contacts
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print(InviteConstants.cencalled)
            viewModel.controller.dismiss(animated: true, completion: nil)
        case .failed:
            print(InviteConstants.failed)
            viewModel.controller.dismiss(animated: true, completion: nil)
        case .sent:
            print(InviteConstants.sent)
            viewModel.controller.dismiss(animated: true, completion: nil)
        default:
            break
        }
        viewModel.controller.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(InviteContactCell.self, for: indexPath)
        cell.configure(with: filterContacts[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension InviteDetailDataSource: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let attribute = [NSAttributedString.Key.backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ] as [NSAttributedString.Key: Any]?
        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        textField.attributedText = NSAttributedString(string: searchText, attributes: attribute)

        if searchText.count != 0 {
            filterContacts = contacts.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                    $0.lastName.lowercased().contains(searchText.lowercased())
            }
        } else { filterContacts = contacts }

        tableView.reloadData()
        return false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}

extension InviteDetailDataSource: InviteContactDelegate {
    
    func sendMessage(with phoneNumber: String) {
        if (MFMessageComposeViewController.canSendText()) {
            let vc = MFMessageComposeViewController()
            vc.body = InviteConstants.inviteMessage
            vc.recipients = [phoneNumber]
            vc.messageComposeDelegate = self
            viewModel.controller.present(vc, animated: true, completion: nil)
        } else {
            print("sent massage to number")
        }
    }
}

