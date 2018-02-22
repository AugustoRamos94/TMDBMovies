//
//  AppCoordinator.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 21/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    //MARK: Properties
    
    let window: UIWindow
    let rootViewController: UINavigationController
    
    //MARK: Init
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
    }
    
    //MARK: Start
    
    func start() {
        window.rootViewController = rootViewController
        showList()
        window.makeKeyAndVisible()
        let genres = DataManager().loadGenres()
        guard genres.isEmpty else { return }
        TMDBRequests.genres(nil)
    }
    
    //MARK: Actions
    
    private func showList() {
        let instance = TMDBUpcomingListViewController()
        instance.delegate = self
        rootViewController.pushViewController(instance, animated: true)
    }
    
    private func showDetail(for movie: Movie) {
        let instance = TMDBDetailViewController(with: movie)
        rootViewController.pushViewController(instance, animated: true)
    }
}

extension AppCoordinator: TMDBUpcomingListDelegate {
    func upcomingList(_ upcoming: TMDBUpcomingListViewController, didSelect movie: Movie) {
        showDetail(for: movie)
    }
}

