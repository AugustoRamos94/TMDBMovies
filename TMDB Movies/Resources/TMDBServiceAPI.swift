//
//  TMDBRequests.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation

class TMDBServiceAPI {
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    private var errorMessage = ""
    
    typealias QueryResult = ([Movie]?, String?) -> Void
    
    func request(_ url: URL, completion: QueryResult) {
        dataTask?.cancel()
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            // 5
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
//                self.updateSearchResults(data)
                // 6
                DispatchQueue.main.async {
                    //completion(self.tracks, self.errorMessage)
                }
            }
        }
        dataTask?.resume()
    }
}
