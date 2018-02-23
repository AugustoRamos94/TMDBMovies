//
//  TMDBRequestEnum.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case DELETE
    case PUT
}

enum TMDBRequestEnum {
    typealias RequestInfo = (url: URL?, method: HTTPMethod)
    enum Movie {
        case upcoming
        case search(String)
        case detail(Int)
        
        func requestInfo(for page: Int = 1) -> RequestInfo {
            let tuple: RequestInfo!
            switch self {
            case .upcoming:
                var urlComponents = URLComponents(string: TMDBRequestEnum.baseURL + "/movie/upcoming")
                urlComponents?.query = "api_key=\(TMDBRequestEnum.apiKey)&page=\(page)"
                tuple = (urlComponents?.url, .GET)
            case .search(let search):
                var urlComponents = URLComponents(string: TMDBRequestEnum.baseURL + "/search/movie")
                urlComponents?.query = "api_key=\(TMDBRequestEnum.apiKey)&query=\(search)&page=\(page)"
                tuple = (urlComponents?.url, .GET)
            case .detail(let id):
                var urlComponents = URLComponents(string: TMDBRequestEnum.baseURL + "/movie/\(id)")
                urlComponents?.query = "api_key=\(TMDBRequestEnum.apiKey)"
                tuple = (urlComponents?.url, .GET)
            }
            return tuple
        }
    }
    
    enum Genre {
        case movie
        
        func requestInfo() -> RequestInfo {
            let tuple: RequestInfo!
            switch self {
            case .movie:
                var urlComponents = URLComponents(string: TMDBRequestEnum.baseURL + "/genre/movie/list")
                urlComponents?.query = "api_key=\(TMDBRequestEnum.apiKey)"
                tuple = (urlComponents?.url, .GET)
            }
            return tuple
        }
    }
    
    //MARK: Private
    private static let baseURL: String = "https://api.themoviedb.org/3"
    private static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
}
