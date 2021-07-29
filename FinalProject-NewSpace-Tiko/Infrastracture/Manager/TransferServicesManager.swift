//
//  TransferServicesManager.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 23.07.21.
//

import UIKit

protocol TransferServicesManagerProtocol: AnyObject {
    func fetchGif(complation: @escaping ([InsideGifData]) -> Void)
    init(with networkMangaer: NetworkManagerProtocol)
}

final class TransferServicesManager: TransferServicesManagerProtocol {
    
    var networkMangaer: NetworkManagerProtocol
    
    init(with networkMangaer: NetworkManagerProtocol) {
        self.networkMangaer = networkMangaer
    }
    
    func fetchGif(complation: @escaping ([InsideGifData]) -> Void) {
        let url = EndPoints.gif.rawValue
        NetworkManager.shared.get(with: url) { (result: Result<GifData, Error>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let gifs):
                complation(gifs.data)
            }
        }
    }
}
