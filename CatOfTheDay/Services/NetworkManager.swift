//
//  NetworkManager.swift
//  CatOfTheDay
//
//  Created by Artem Lapov on 09.11.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link: String {
    case imageURL = "https://cataas.com/cat"
    case factURL = "https://meowfacts.herokuapp.com"
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchCatImage(from url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
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

    func fetchCatFact(from url: String, completion: @escaping(Result<Fact, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }

            do {
                let fact = try JSONDecoder().decode(Fact.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(fact))
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


