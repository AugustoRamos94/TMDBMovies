//
//  TMDBRequestEnum.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation
enum TMDBRequestEnum {
    case upcoming
    case search(String)
    case detail(Int)
    case genre
    
    func url(for page: Int = 1) -> URL? {
        let urlComponents: URLComponents!
        switch self {
        case .upcoming:
            urlComponents = URLComponents(string: TMDBRequestEnum.baseURL + "/movie/upcoming")
            urlComponents.query = "api_key=\(TMDBRequestEnum.apiKey)&page=\(page)"
        case .search(let search):
            urlComponents = URLComponents(string: TMDBRequestEnum.baseURL + "/search/movie")
            urlComponents.query = "api_key=\(TMDBRequestEnum.apiKey)&query=\(search)&page=\(page)"
        case .detail(let id):
            urlComponents = URLComponents(string: TMDBRequestEnum.baseURL + "/movie/\(id)")
            urlComponents.query = "api_key=\(TMDBRequestEnum.apiKey)"
        case .genre:
            urlComponents = URLComponents(string: TMDBRequestEnum.baseURL + "/genre/movie/list")
            urlComponents.query = "api_key=\(TMDBRequestEnum.apiKey)"
        }
        return urlComponents.url
    }
    
    //MARK: Private
    private static let baseURL: String = "https://api.themoviedb.org/3"
    private static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
}
