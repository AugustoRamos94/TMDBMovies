//
//  TMDBAPIResponse.swift
//  TMDB Movies
//
//  Created by Augusto Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation

struct TMDBAPIResponse: Decodable {
    
    var results: [Movie]
    
    enum CodingKeys : String, CodingKey {
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([Movie].self, forKey: .results)
    }
}
