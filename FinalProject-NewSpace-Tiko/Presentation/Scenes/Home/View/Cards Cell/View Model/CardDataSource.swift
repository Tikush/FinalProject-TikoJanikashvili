//
//  CardDataSource.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit

class CardDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - IBOutlets
    private var collectionView: UICollectionView!
    private var viewModel: CardViewModelProtocol!
    private var cards: [Card] = []
    
    init(with collectionView: UICollectionView, cards: [Card], viewModel: CardViewModelProtocol) {
        super.init()
        
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.viewModel = viewModel
        self.cards = cards
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(CardsItemCell.self, for: indexPath)
        cell.configure(with: cards[indexPath.row])
        return cell
    }
}

extension CardDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectioen")
    }
}

extension CardDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
}

