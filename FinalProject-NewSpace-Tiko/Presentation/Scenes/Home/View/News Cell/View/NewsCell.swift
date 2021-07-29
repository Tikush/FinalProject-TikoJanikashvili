//
//  CoverCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit

class NewsCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    
    // MARK: - Private Properties
    private var viewModel: NewsViewModelProtocol!
    private var datasource: NewsDataSource!
    private var coordinator: CoordinatorProtocol?
    private var news: [News] = []
    
    // MARK: - Life Cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout() {
        collectionView.registerNib(class: NewsItemCell.self)
    }
    
    func configure(with news: [News], coordinator: CoordinatorProtocol) {
        self.news = news
        self.coordinator = coordinator
        configureViewModel()
    }
    
    private func configureViewModel() {
        viewModel = NewsViewModel(with: coordinator!)
        datasource = NewsDataSource(with: collectionView, news: news, viewModel: viewModel)
    }
}

