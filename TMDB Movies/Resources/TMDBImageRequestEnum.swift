//
//  TMDBImageRequestEnum.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 22/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation
enum TMDBImageRequestEnum {
    enum Backdrop: String {
        case w300
        case w780
        case w1280
        case original
        
        func url(for path: String) -> URL? {
            return URL(string: TMDBImageRequestEnum.apiKey + self.rawValue + "/" + path)
        }
    }
    
    enum PosterSizes: String {
        case w92
        case w154
        case w185
        case w342
        case w500
        case w780
        case original
        
        func url(for path: String) -> URL? {
            return URL(string: TMDBImageRequestEnum.apiKey + self.rawValue + "/" + path)
        }
    }
    
    private static let apiKey = "https://image.tmdb.org/t/p/"
}
