//
//  TMDBAPIResponse.swift
//  TMDB Movies
//
//  Created by Augusto Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation

struct TMDBAPIResponse: Decodable {
    
    struct Dates: Codable {
        var maximum: String
        var minimum: String
    }
    
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Movie]
    var dates: Dates
    
    enum CodingKeys : String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
        case dates = "dates"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        results = try container.decode([Movie].self, forKey: .results)
        dates = try container.decode(Dates.self, forKey: .dates)
    }
}
