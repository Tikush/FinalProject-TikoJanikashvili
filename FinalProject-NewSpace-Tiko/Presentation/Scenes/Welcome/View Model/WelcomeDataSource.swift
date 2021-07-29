//
//  WelcomeDataSource.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 16.07.21.
//

import UIKit
import Foundation

class WelcomeDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Private Properties
    private var collectionView: UICollectionView
    private var welcomeData: [Welcome]
    private var pageControl: UIPageControl
    private var currentPage = 0
    
    // MARK: - Init
    init(collectionView: UICollectionView, welcomeData: [Welcome], pageControl: UIPageControl) {
        self.collectionView = collectionView
        self.welcomeData = welcomeData
        self.pageControl = pageControl
        super.init()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return welcomeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(WelcomeCell.self, for: indexPath)
        cell.configure(with: welcomeData[indexPath.row])
        return cell
    }
}

extension WelcomeDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width * 1.2)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        DispatchQueue.main.async {
            self.pageControl.currentPage = self.currentPage
        }
    }
}
