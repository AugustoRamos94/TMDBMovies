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
        }
    }
    
    //MARK: Properties
    
    private var datasource = TMDBDatasource()
    private var request = TMDBRequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
    }
    
    //MARK: Request
    
    private func makeRequest(search: String = "") {
        if !search.isEmpty {
            request.config = .search(search)
        } else {
            request.config = .upcoming
        }
        request.run() { _ in
            
        }
    }
}
