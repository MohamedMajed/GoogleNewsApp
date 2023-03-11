//
//  APIService.swift
//  InfraLayerTask
//
//  Created by Mohamed Maged on 01/03/2023.
//

import Foundation
import Reachability

protocol ArticlesService {
    func fetchArticles(completion: @escaping (Result<ArticleResponse, Error>) -> Void)
}

class APIService: ArticlesService {
    
    let reachability = try! Reachability()
    func fetchArticles(completion: @escaping (Result<ArticleResponse, Error>) -> Void ) {
        let URLString = "https://newsapi.org/v2/everything?q=tesla&from=2023-02-06&sortBy=publishedAt&apiKey=51b329140d344a59bdcebb0978bfb77b".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: URLString)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601


        executeRequest(url: url, httpMethod: "GET", payload: nil, decoding: ArticleResponse.self, using: decoder, completion: completion)
    }


    func executeRequest<T: Decodable>(url: URL, httpMethod: String, payload: Data?, decoding: T.Type, using decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, Error>) -> Void) {
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                
                var request = URLRequest(url: url)
                request.httpMethod = httpMethod
                request.httpBody = payload
                URLSession.shared.dataTask(with: request) { data, response, error in

                    do {
                        if let error = error { throw error }

                        guard let data = data else {
                            completion(.failure(APIError.dataNotFound))
                            return
                        }
                        let decodedModel = try decoder.decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(decodedModel))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                        print(error.localizedDescription)
                    }
                }.resume()
            } else {
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
       
    }
}
