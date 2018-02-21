//
//  TMDBRequests.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation
import CoreData

class TMDBRequests {
    //MARK: Properties
    var page: Int = 1
    var config: TMDBRequestEnum! {
        didSet {
            page = 1
        }
    }
    private var request = TMDBServiceAPI()
    
    //MARK: Init
    init() {
        config = .upcoming
    }
    
    convenience init(with config: TMDBRequestEnum) {
        self.init()
        self.config = config
    }
    
    //MARK: Request
    
    func run(_ completion: @escaping (([Movie]) -> Void)) {
        guard let url = config.url(for: page) else { return }
        request.request(url) {(data, error) in
            guard let data = data else {
                return
            }
            let movies: [Movie]
            if let stringData = String(data: data, encoding: .utf8),
                let data = JSONDecoder.decode(TMDBAPIResponse.self, from: stringData) {
                movies = data.results
            } else {
                movies = []
            }
            completion(movies)
        }
    }
    
    static func genres(_ completion: @escaping (([Genre]) -> Void)) {
        guard let url = TMDBRequestEnum.genre.url() else { return }
        TMDBServiceAPI().request(url) {(data, error) in
            guard let data = data else {
                return
            }
            let genres: [Genre]
            if let stringData = String(data: data, encoding: .utf8),
                let data = JSONDecoder.decode([String: [Genre]].self, from: stringData),
                let genresModels = data["genres"] {
                genres = genresModels
            } else {
                genres = []
            }
            completion(genres)
        }
    }
}
