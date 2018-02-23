//
//  TMDBRequests.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation

class TMDBServiceAPI {
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    typealias QueryResult = (Data?, String?) -> Void
    
    func request(_ url: URL, method: HTTPMethod,  completion: @escaping QueryResult) {
        dataTask?.cancel()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        dataTask = defaultSession.dataTask(with: urlRequest) { data, response, error in
            defer { self.dataTask = nil }
            var errorMessage: String?
            if let error = error {
                errorMessage = "DataTask error: " + error.localizedDescription + "\n"
            }
            DispatchQueue.main.async {
                completion(data, errorMessage)
            }
        }
        dataTask?.resume()
    }
}
