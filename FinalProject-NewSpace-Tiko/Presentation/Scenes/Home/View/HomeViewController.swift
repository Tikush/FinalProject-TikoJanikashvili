//
//  HomeViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 18.07.21.
//

import UIKit

class HomeViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Properties
    private var viewModel: HomeViewModelProtocol!
    private var datasource: HomeDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureViewModel()
        coordinator?.homeServiceManager?.fetchHomeData()
    }
    
    private func setupLayout() {
        tableView.registerNib(class: TopMoneyCell.self)
        tableView.registerNib(class: NewsCell.self)
        tableView.registerNib(class: CardsCell.self)
        tableView.registerNib(class: InviteFriendCell.self)
        tableView.registerNib(class: HelpCell.self)
    }
   
    private func configureViewModel() {
        viewModel = HomeViewModel(with: self)
        datasource = HomeDataSource(with: tableView, viewModel: viewModel)
        datasource.loadNews()
        datasource.loadCards()
    }
}
