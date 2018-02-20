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
    private var errorMessage = ""
    
    typealias QueryResult = (Data?, String?) -> Void
    
    func request(_ url: URL, completion: @escaping QueryResult) {
        dataTask?.cancel()
        
        var request = URLRequest.init(url: url,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
        request.httpMethod = "GET"

        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                if let stringData = String(data: data, encoding: String.Encoding.utf8),
                    let jsonDecoder = JSONDecoder.decode([String: [Movie]].self, from: stringData) {
                    
                    print(jsonDecoder["results"])
                }
                DispatchQueue.main.async { [weak self] in
                    completion(data, self?.errorMessage)
                }
            }
        }
        dataTask?.resume()
    }
}
