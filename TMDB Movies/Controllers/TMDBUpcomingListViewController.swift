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
    
    //MARK: Methods
    
    private func makeRequest(search: String = "") {
        
    }
    
    
}
