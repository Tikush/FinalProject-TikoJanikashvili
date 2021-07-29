//
//  CoverDataSource.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit

class NewsDataSource: NSObject, UICollectionViewDataSource {
    
    private var collectionView: UICollectionView!
    private var viewModel: NewsViewModelProtocol!
    private var news: [News] = []
    
    init(with collectionView: UICollectionView, news: [News], viewModel: NewsViewModelProtocol) {
        super.init()
        
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.viewModel = viewModel
        self.news = news
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(NewsItemCell.self, for: indexPath)
        cell.configure(with: news[indexPath.row])
        return cell
    }
}

extension NewsDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectioen")
        viewModel.coordinator.proceedToNewsDetailPage(with: news[indexPath.row])
        
    }
}

extension NewsDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3, height: collectionView.bounds.width / 3 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
