//
//  TMDBRequestsProtocol.swift
//  TMDB Movies
//
//  Created by Augusto Ramos on 21/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation
import UIKit

protocol TMDBControllerRequestsHandlerProtocol: class {
    var request: TMDBRequests { get }
    var datasource: TMDBDatasource { get }
    var staticMovies: [Movie] { get }
    var typeList: TMDBRequestEnum.Movie { get }
    
    func reloadData()
}

extension TMDBControllerRequestsHandlerProtocol where Self: UIViewController {
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
    
    func requestRefresh(_ config: TMDBRequestEnum.Movie, completion: (() -> Void)? = nil) {
        let request = TMDBRequests(with: typeList)
        request.run {[weak self] (movies, error) in
            guard let strongSelf = self else { return }
            guard error == nil else {
                strongSelf.showAlertError(completion: completion) {
                    strongSelf.requestRefresh(config, completion: completion)
                }
                return
            }
            strongSelf.datasource.items = strongSelf.staticMovies
            strongSelf.reloadData()
            completion?()
        }
    }
}
