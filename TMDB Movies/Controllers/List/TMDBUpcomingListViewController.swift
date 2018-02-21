//
//  TMDBUpcomingListViewController.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 21/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import UIKit

protocol TMDBUpcomingListDelegate: class {
    func upcomingList(_ upcoming: TMDBUpcomingListViewController, didSelect movie: Movie)
}

class TMDBUpcomingListViewController: UIViewController {

    //MARK: IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.keyboardDismissMode = .onDrag
            collectionView?.dataSource = datasource
            collectionView?.delegate = self
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
    weak var delegate: TMDBUpcomingListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
    }
    
    //MARK: Setup
    
    @objc private func refresh(_ refresh: UIRefreshControl) {
        
        refresh.endRefreshing()
    }
    
    //MARK: Request
    
    private func makeRequest(search: String? = "",
                             completion: (() -> Void)? = nil) {
        func sucessRequest(_ movies:[Movie]) {
            if request.page == 1 {
                datasource.items = movies
            } else {
                datasource.items.append(contentsOf: movies)
            }
            collectionView?.reloadData()
            completion?()
        }
        
        func failRequest() {
            showAlertError(tryAgainCompletion: { [weak self] in
                self?.makeRequest(search: search, completion: completion)
            })
        }
        
        if let search = search, !search.isEmpty {
            request.config = .search(search)
        } else {
            request.config = .upcoming
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
}

extension TMDBUpcomingListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        defer { collectionView.deselectItem(at: indexPath, animated: false) }
        delegate?.upcomingList(self, didSelect: datasource.items[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.item == datasource.items.count {
            request.page += 1
            makeRequest(search: searchBar.text)
        }
    }
}

extension TMDBUpcomingListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        makeRequest(search: searchBar.text)
    }
}
