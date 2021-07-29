//
//  PaymentDetailsViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit

class PaymentDetailsViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchView: UIView!
    
    // MARK: - Private Properties
    private var networkManager: NetworkManagerProtocol!
    private var paymentManager: PaymentServicesManagerProtocol!
    private var viewModel: PaymentDetailsViewModelProtocol!
    private var datasource: PaymentDetailsDataSource!
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureViewModel()
        bindings()
        dismissKeyboard()
    }
    
    private func configureViewModel() {
        networkManager = NetworkManager()
        paymentManager = PaymentServicesManager(with: networkManager)
        viewModel = PaymentDetailsViewModel(with: paymentManager, navigationController: navigationController, controller: self )
        datasource = PaymentDetailsDataSource(with: tableView, searchTextField: searchTextField, viewModel: viewModel)
        datasource.refresh()
    }
    
    private func setupLayout() {
        tableView.registerNib(class: PaymentCell.self)
        searchView.cornerView(cornerRadius: 12, borderWidth: 0.3, borderColor: .lightGray)
    }
    
    private func bindings() {
        viewModel.didFinishedLoading = {
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction private func close(_ sender: Any) {
        viewModel.controller.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func back(_ sender: Any) {
        viewModel.controller.navigationController?.popViewController(animated: true)
    }
}
