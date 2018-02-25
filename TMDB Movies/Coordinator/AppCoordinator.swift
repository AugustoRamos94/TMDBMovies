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
        rootViewController.navigationBar.barTintColor = .appColor
        let textAttributes: [NSAttributedStringKey: UIColor] = [.foregroundColor: .white]
        rootViewController.navigationBar.titleTextAttributes = textAttributes
        rootViewController.navigationBar.tintColor = .white
    }
    
    //MARK: Start
    
    func start() {
        window.rootViewController = rootViewController
        showList()
        window.makeKeyAndVisible()
        let genres = DataManager.shared.loadGenres()
        guard genres.isEmpty else { return }
        TMDBRequests.genres(nil)
    }
    
    //MARK: Actions
    
    func showList() {
        let instance = TMDBListViewController()
        instance.delegate = self
        rootViewController.pushViewController(instance, animated: true)
    }
    
    func showDetail(movie: Movie) {
        let instance = TMDBDetailViewController(with: movie)
        rootViewController.pushViewController(instance, animated: true)
    }
}

extension AppCoordinator: TMDBUpcomingListDelegate {
    func upcomingList(_ upcoming: TMDBListViewController, didSelect movie: Movie) {
        showDetail(movie: movie)
    }
}

