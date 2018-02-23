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
    var config: TMDBRequestEnum.Movie! {
        didSet { page = 1 }
    }
    private var request = TMDBServiceAPI()
    
    //MARK: Init
    
    init() { config = .upcoming }
    
    convenience init(with config: TMDBRequestEnum.Movie) {
        self.init()
        self.config = config
    }
    
    //MARK: Request
    
    func run(_ completion: QueryMovieResult?) {
        let info = config.requestInfo(for: page)
        guard let url = info.url else { return }
        
        request.request(url, method: info.method) {(data, error) in
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
        let info = TMDBRequestEnum.Genre.movie.requestInfo()
        guard let url = info.url else { return }
        
        TMDBServiceAPI().request(url, method: info.method) {(data, error) in
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
