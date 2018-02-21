//
//  TMDBUpcomingListViewController.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import UIKit

class TMDBUpcomingListViewController: UIViewController {
    //MARK: IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView?.dataSource = datasource
            collectionView.register(TMDBMovieCollectionViewCell.nib(),
                                    forCellWithReuseIdentifier: TMDBMovieCollectionViewCell.identifier)
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
            collectionView.refreshControl = refreshControl
        }
    }
    
    //MARK: Properties
    
    private var datasource = TMDBDatasource()
    private var request = TMDBRequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
    }
    
    //MARK: Setup
    
    @objc private func refresh(_ refresh: UIRefreshControl) {
        
        refresh.endRefreshing()
    }
    
    //MARK: Request
    
    private func makeRequest(search: String = "") {
        if !search.isEmpty {
            request.config = .search(search)
        } else {
            request.config = .upcoming
        }
        
        let loadingViewController = LoadingViewController()
        add(loadingViewController)
        
        request.run() {[weak self] (movies) in
            self?.datasource.items = movies
            self?.collectionView.reloadData()
            
            loadingViewController.remove()
        }
    }
}
