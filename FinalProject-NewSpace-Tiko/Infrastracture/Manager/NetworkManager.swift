//
//  NetworkManager.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 18.07.21.
//

import UIKit

enum EndPoints: String {
    case gif = "https://api.giphy.com/v1/gifs/trending?api_key=fSvsRdK813Z11MeF1leIoEe1EEmXk1bH&limit=15&rating=G"
    case payment = "https://mocki.io/v1/cbe5e02a-3441-48a1-a4b9-3a20544adaa4"
    case news = "https://mocki.io/v1/d6802cf3-4b64-4a9a-ae0f-2dc2e9c5e543"
}

protocol NetworkManagerProtocol: AnyObject {
    func getWithRequest<T: Codable>(with url: String, completion: @escaping (Result<T, Error>) -> Void)
    func get<T: Codable>(with url: String, completion: @escaping ((Result<T, Error>) -> Void))
}

final class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    func getWithRequest<T: Codable>(with url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func get<T: Codable>(with url: String, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

