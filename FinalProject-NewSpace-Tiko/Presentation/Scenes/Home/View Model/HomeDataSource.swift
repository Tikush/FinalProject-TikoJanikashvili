//
//  HomeDataSource.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit

class HomeDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Private Properies
    private var tableView: UITableView!
    private var viewModel: HomeViewModelProtocol!
    private var news = [News]()
    private var cards = [Card]()
    
    init(with tableView: UITableView, viewModel: HomeViewModelProtocol) {
        super.init()
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel = viewModel
    }
    
    func loadNews() {
        viewModel.fetchNews { [weak self] result in
            switch result {
            case .success(let news):
                self?.news = news
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func loadCards() {
        cards.append(Card(image: UIImage(named: "ic_space"), name: "Space", number: "*737"))
        cards.append(Card(image: UIImage(named: "ic_tbc"), name: "TBC", number: "*157"))
        cards.append(Card(image: UIImage(named: "ic_stu"), name: "TBC-St", number: "*148"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.deque(TopMoneyCell.self, for: indexPath)
            return cell
        case 1:
            let cell = tableView.deque(NewsCell.self, for: indexPath)
            if !news.isEmpty {
                cell.configure(with: news, coordinator: viewModel.controller.coordinator!)
            }
            return cell
        case 2:
            let cell = tableView.deque(CardsCell.self, for: indexPath)
            if !cards.isEmpty {
                cell.configure(with: cards, coordinator: viewModel.controller.coordinator!)
            }
            return cell
        case 3:
            let cell = tableView.deque(InviteFriendCell.self, for: indexPath)
            return cell
        case 4:
            let cell = tableView.deque(HelpCell.self, for: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension HomeDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        switch indexPath.row {
        case 3:
            viewModel.controller.coordinator?.proceedToInvitePage()
        default:
            break
        }
    }
}

