//
//  NetworkServerce.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 28.08.2023.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func getDataAdvertisement(urlString: String, completion: @escaping (Result<Advertisement, Error>) -> Void)
    func getDataItemDetailed(urlString: String, completion: @escaping (Result<ItemDetailedModel, Error>) -> Void)
}


class NetworkService: NetworkServiceProtocol {
    
    func getDataAdvertisement(urlString: String, completion: @escaping (Result<Advertisement, Error>) -> Void) {
        request(urlString: urlString, completion: completion)
    }
    func getDataItemDetailed(urlString: String, completion: @escaping (Result<ItemDetailedModel, Error>) -> Void) {
        request(urlString: urlString, completion: completion)
    }
    
    private func request<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void ) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                
                do {
                    let tracks = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(tracks))
                } catch let jsonError {
                    print("faild to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
