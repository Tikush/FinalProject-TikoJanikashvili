//
//  Gifs.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 23.07.21.
//

import UIKit

protocol GifsDelegate: AnyObject {
    func selectGif(imageUrl: String)
}

class Gifs: UIView {

    // MARK: - IBOutlets
    @IBOutlet private weak var searchGif: UITextField!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var lineView: UIView!
    
    // MARK: Properties
    weak var delegate: GifsDelegate?
    private var gifManager: TransferServicesManagerProtocol!
    private var networkManager: NetworkManagerProtocol!
    var gifList = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - View LifeCyrle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.loadGif()
        self.setupLayout()
        self.configureManager()
    }
    
    private func configureManager() {
        networkManager = NetworkManager()
        gifManager = TransferServicesManager(with: networkManager)
        gifManager.fetchGif { [weak self] data in
            self?.gifList = data.compactMap { $0.images.fixed_height.url }
        }
    }
    
    private func setupLayout() {
        lineView.cornerView(cornerRadius: 2.5, borderWidth: 0.2, borderColor: .gray)
        collectionView.backgroundColor = .clear
    }
    
    // MARK: - Load gif collection
    private func loadGif() {
        collectionView.registerNib(class: GifsCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension Gifs: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gifList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifsCell", for: indexPath) as? GifsCell
        cell?.setCell(with: self.gifList[indexPath.row])
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectGif(imageUrl: self.gifList[indexPath.row])
    }
}

extension Gifs: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.collectionView.frame.width / 4, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}
