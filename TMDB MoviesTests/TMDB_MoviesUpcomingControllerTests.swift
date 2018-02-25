//
//  TMDB_MoviesUpcomingControllerTests.swift
//  TMDB MoviesTests
//
//  Created by Augusto Ramos on 23/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import XCTest
@testable import TMDB_Movies

class TMDB_MoviesUpcomingControllerTests: XCTestCase {
    var movieTest: Movie {
        get {
            let movie = Movie.mock()
            movie.id = 1
            movie.title = "TMDB_MoviesUpcomingControllerTests 1"
            movie.overview = "overview"
            movie.releaseDate = NSDate()
            movie.genres_ids = [10, 20]
            
            return movie
        }
    }
    
    var movieTestTwo: Movie {
        get {
            let movie = Movie.mock()
            movie.id = 2
            movie.title = "TMDB_MoviesUpcomingControllerTests 2"
            movie.overview = "overview"
            movie.releaseDate = NSDate()
            movie.genres_ids = [10, 20]
            
            return movie
        }
    }
    
    var listController: TMDBListViewController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let listController = TMDBListViewController(typeList: .upcoming)
        self.listController = listController
        guard self.listController != nil else {
            XCTAssert(false, "Bug: not instantiate TMDBUpcomingListViewController")
            return
        }
        _ = self.listController!.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        DataManager.shared.delete(objects: [movieTest, movieTestTwo])
    }
    
    func testDataSourceItems() {
        XCTAssertTrue(listController!.datasource.items.count == listController!.staticMovies.count, "Bug: items not equal")
    }
    
    func testSearchBar() {
        listController?.datasource.items = [movieTest, movieTestTwo]
        XCTAssertTrue(listController?.datasource.items.count == 2, "Bug: items not equal")
        listController?.collectionView.reloadData()
        XCTAssertTrue(listController?.collectionView.numberOfItems(inSection: 0) == 2, "Bug: collection not right")
        
        let moviesTest = DataManager.shared.loadMovies().filter({ $0.title == movieTest.title && $0.id == movieTest.id })
        moviesTest.forEach({ DataManager.shared.context.delete($0) })
        
        
        DataManager.shared.save(movies: [movieTest])
        listController?.searchBar.text = movieTest.title
        listController?.searchBar(listController!.searchBar, textDidChange: movieTest.title)
        listController?.searchBarSearchButtonClicked(listController!.searchBar)
        XCTAssertTrue(listController?.collectionView.numberOfItems(inSection: 0) == 1, "Bug: collection not right")
    }
}
