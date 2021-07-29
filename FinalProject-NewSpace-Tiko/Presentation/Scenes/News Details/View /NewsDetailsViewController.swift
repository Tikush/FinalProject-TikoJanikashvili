//
//  NewsDetailsViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit
import Kingfisher

class NewsDetailsViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Properties
    private var viewModel: NewsDetailsViewModelProtocol!
    private var datasource: NewsDetailsDataSource!
    
    // MARK: - Internal Properties
    var news: News?
    
    private var imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        return img
    }()
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        view.addSubview(imageView)
    }
    
    private func setupLayout() {
        guard let news = news else { return }
        tableView.registerNib(class: ContentCell.self)
        tableView.contentInset = UIEdgeInsets(top: 350, left: 0, bottom: 0, right: 0)
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 350)
        imageView.kf.setImage(with: URL(string: news.image ?? ""))
    }
    
    private func configureViewModel() {
        guard let news = news else { return }
        viewModel = NewsDetailsViewModel(with: self)
        datasource = NewsDetailsDataSource(tableView: tableView, image: imageView, news: news, viewModel: viewModel)
        datasource.refresh()
    }
    
    @IBAction private func back() {
        viewModel.controller.navigationController?.popViewController(animated: true)
    }
    
}
