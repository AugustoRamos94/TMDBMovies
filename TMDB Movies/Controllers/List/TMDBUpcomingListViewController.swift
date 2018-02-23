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

class TMDBUpcomingListViewController: UIViewController, TMDBControllerRequestsHandlerProtocol {
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
    var request = TMDBRequests()
    var typeList: TMDBRequestEnum.Movie = .upcoming
    weak var delegate: TMDBUpcomingListDelegate?
    var staticMovies: [Movie] {
        return DataManager.shared.loadMovies()
    }
    
    //MARK: Init
    
    convenience init(typeList: TMDBRequestEnum.Movie = .upcoming) {
        self.init()
        self.typeList = typeList
        request = TMDBRequests(with: typeList)
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Upcoming"
        let movies = staticMovies
        guard movies.isEmpty else {
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

extension TMDBUpcomingListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        defer { collectionView.deselectItem(at: indexPath, animated: false) }
        delegate?.upcomingList(self, didSelect: datasource.items[indexPath.item])
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < 0 { return }
        if scrollView.contentOffset.y + scrollView.frame.height > scrollView.contentSize.height {
            request.page += 1
            makeRequest()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  30
        let collectionViewSize = collectionView.frame.size.width - padding
        let columns: CGFloat = UIDevice.current.orientation == .portrait ? 2.0 : 4.0
        return CGSize(width: collectionViewSize/columns,
                      height: collectionViewSize/columns)
    }
}

extension TMDBUpcomingListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        let filteredItems = staticMovies.filter({ $0.title.contains(searchText) })
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
        searchBar.resignFirstResponder()
    }
}
