//
//  DetailsContentDataSOurce.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit

class NewsDetailsDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Private Properties
    private var tableView: UITableView!
    private var viewModel: NewsDetailsViewModelProtocol!
    private var contentList: [String] = []
    private var image: UIImageView!
    
    init(tableView: UITableView, image: UIImageView, news: News, viewModel: NewsDetailsViewModelProtocol) {
        self.contentList = news.content ?? []
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.viewModel = viewModel
        self.image = image
    }
    
    func refresh() {
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(ContentCell.self, for: indexPath)
        cell.configure(with: contentList[indexPath.row])
        return cell
    }
}

extension NewsDetailsDataSource: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = -scrollView.contentOffset.y
        let height = max(y, 200)
        image.frame = CGRect(x: 0, y: 0, width: viewModel.controller.view.frame.width, height: height)
    }
}
