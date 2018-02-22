//
//  TMDBRequestsProtocol.swift
//  TMDB Movies
//
//  Created by Augusto Ramos on 21/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation
import UIKit

protocol TMDBRequestsProtocol: class {
    var request: TMDBRequests { get }
    var datasource: TMDBDatasource { get }
    var staticMovies: [Movie] { get set }
    
    func reloadData()
}

extension TMDBRequestsProtocol where Self: UIViewController {
    //MARK: Request
    
    func makeRequest(_ completion: (() -> Void)? = nil) {
        func sucessRequest(_ movies:[Movie]) {
            if request.page == 1 {
                datasource.items = movies
            } else {
                datasource.items.append(contentsOf: movies)
            }
            reloadData()
            completion?()
        }
        
        func failRequest() {
            showAlertError(completion: completion) { [weak self] in
                self?.makeRequest(completion)
            }
        }
        
        let loadingViewController = LoadingViewController()
        add(loadingViewController)
        
        request.run() {(movies, error) in
            loadingViewController.remove()
            guard let movies = movies else {
                failRequest()
                return
            }
            sucessRequest(movies)
        }
    }
    
    func requestRefresh(_ config: TMDBRequestEnum, completion: (() -> Void)? = nil) {
        let request = TMDBRequests()
        request.config = config
        request.run {[weak self] (movies, error) in
            guard let strongSelf = self else { return }
            guard let movies = movies else {
                strongSelf.showAlertError(completion: completion) {
                    strongSelf.requestRefresh(config, completion: completion)
                }
                return
            }
            let existingIds = strongSelf.staticMovies.map({$0.id})
            let newItems = movies.filter({ !existingIds.contains($0.id) })
            DataManager().save(movies: newItems)
            strongSelf.staticMovies = newItems + strongSelf.staticMovies
            strongSelf.reloadData()
            completion?()
        }
    }
}
