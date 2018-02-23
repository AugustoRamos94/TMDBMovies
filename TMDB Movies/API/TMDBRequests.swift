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
    
    typealias QueryMovieResult = (([Movie]?, String?) -> Void)
    typealias QueryGenreResult = (([Genre]?, String?) -> Void)
    var page: Int = 1
    var config: TMDBRequestEnum! {
        didSet { page = 1 }
    }
    private var request = TMDBServiceAPI()
    
    //MARK: Init
    
    init() { config = .upcoming }
    
    convenience init(with config: TMDBRequestEnum) {
        self.init()
        self.config = config
    }
    
    //MARK: Request
    
    func run(_ completion: QueryMovieResult?) {
        guard let url = config.url(for: page) else { return }
        request.request(url) {(data, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            
            //PARSE MOVIES
            
            let movies: [Movie]
            if let stringData = String(data: data, encoding: .utf8),
                let data = JSONDecoder.decode(TMDBAPIResponse.self, from: stringData) {
                movies = data.results
            } else {
                movies = []
            }
            
            //SAVING
            
            let existingIds = DataManager.shared.loadMovies().map({$0.id})
            let newItems = movies.filter({ !existingIds.contains($0.id) })
            if !newItems.isEmpty {
                DataManager.shared.save(movies: newItems)
            }
            
            completion?(movies, nil)
        }
    }
    
    static func genres(_ completion: QueryGenreResult?) {
        guard let url = TMDBRequestEnum.genre.url() else { return }
        TMDBServiceAPI().request(url) {(data, error) in
            guard let data = data else {
                completion?(nil, error)
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
            DataManager.shared.save(genres: genres)
            completion?(genres, nil)
        }
    }
}
