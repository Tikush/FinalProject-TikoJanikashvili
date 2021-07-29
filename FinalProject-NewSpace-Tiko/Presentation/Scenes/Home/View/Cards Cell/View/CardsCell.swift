//
//  CardsCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit

class CardsCell: UITableViewCell {

    // MARK: - IBoutlets
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var transferButton: UIButton!
    @IBOutlet private weak var cardView: UIView!
    
    // MARK: - Private Properties
    private var viewModel: CardViewModelProtocol!
    private var datasource: CardDataSource!
    private var coordinator : CoordinatorProtocol!
    private var cards: [Card] = []
    
    // MARK: - Life Cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout() {
        collectionView.registerNib(class: CardsItemCell.self)
        collectionView.backgroundColor = .clear
        mainView.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: Constants.Color.brandBlue)
        cardView.backgroundColor = Constants.Color.lightGray
        cardView.layer.cornerRadius = 10
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        transferButton.layer.cornerRadius = 10
        transferButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func configure(with cards: [Card], coordinator: CoordinatorProtocol) {
        self.cards = cards
        self.coordinator = coordinator
        configureViewModel()
    }
    
    private func configureViewModel() {
        viewModel = CardViewModel(with: coordinator!)
        datasource = CardDataSource(with: collectionView, cards: cards, viewModel: viewModel)
    }
}
