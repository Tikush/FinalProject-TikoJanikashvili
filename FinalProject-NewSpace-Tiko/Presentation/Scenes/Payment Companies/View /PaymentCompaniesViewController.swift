//
//  PaymentCompaniesViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 20.07.21.
//

import UIKit

class PaymentCompaniesViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    
    // MARK: - Private Properties
    private var networkManager: NetworkManagerProtocol!
    private var paymentManager: PaymentServicesManagerProtocol!
    private var viewModel: CompaniesViewModelProtocol!
    private var datasource: CompaniesDataSource!
    
    // MARK: - Internal Properties
    var categoryName: String?
    
    // MARK: - Life Cyrle
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
        setupLayout()
        configureViewModel()
        bindings()
    }
    
    // MARK: - Private functions
    private func configureViewModel() {
        networkManager = NetworkManager()
        paymentManager = PaymentServicesManager(with: networkManager)
        viewModel = CompaniesViewModel(with: self.paymentManager, navigationController: self.navigationController, controller: self, categoryName: categoryName ?? "")
        datasource = CompaniesDataSource(with: self.tableView, searchTextField: searchTextField, viewModel: self.viewModel)
        datasource.refresh()
    }
    
    private func setupLayout() {
        tableView.registerNib(class: CompanyCell.self)
        categoryNameLabel.text = categoryName
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
