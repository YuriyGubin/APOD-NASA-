//
//  NetworkManager.swift
//  APOD(NASA)
//
//  Created by Yuriy on 24.02.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link: String {
    case pictureUrl = "https://api.nasa.gov/planetary/apod?start_date=2023-02-15&api_key=2wFOs9LvwMlowZyKVWTkM5rTKwpA6GtjDwE72YUa"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
