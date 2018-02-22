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

class TMDBUpcomingListViewController: UIViewController, TMDBRequestsProtocol {
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
    
    var datasource = TMDBDatasource()
    var request = TMDBRequests(with: .upcoming)
    weak var delegate: TMDBUpcomingListDelegate?
    var staticMovies: [Movie] = []
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let movies = DataManager().loadMovies()
        guard movies.isEmpty else {
            staticMovies = movies
            datasource.items = movies
            reloadData()
            return
        }
        makeRequest()
    }
    
    //MARK: Setup
    
    @objc private func refresh(_ refresh: UIRefreshControl) {
        requestRefresh(.upcoming) {
            refresh.endRefreshing()
        }
    }
    
    func reloadData() {
        collectionView?.reloadData()
    }
}

extension TMDBUpcomingListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        defer { collectionView.deselectItem(at: indexPath, animated: false) }
        delegate?.upcomingList(self, didSelect: datasource.items[indexPath.item])
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < 0 { return }
        if scrollView.contentOffset.y + scrollView.frame.height > scrollView.contentSize.height {
            request.page += 1
            makeRequest()
        }
    }
}

extension TMDBUpcomingListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        let filteredItems = staticMovies.filter({ $0.title?.contains(searchText) ?? false })
        if filteredItems.isEmpty {
            datasource.items = staticMovies
        } else {
            datasource.items = filteredItems
        }
        reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        request = TMDBRequests(with: searchBar.text!.isEmpty ? .upcoming : .search(searchBar.text!))
        makeRequest()
    }
}
