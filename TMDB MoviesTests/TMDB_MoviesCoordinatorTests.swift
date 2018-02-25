//
//  TMDB_MoviesCoordinatorTests.swift
//  TMDB MoviesTests
//
//  Created by Augusto Ramos on 23/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import XCTest
@testable import TMDB_Movies

class TMDB_MoviesCoordinatorTests: XCTestCase {
    
    var movieTestOne: Movie {
        get {
            let movie = Movie.mock()
            movie.id = 1
            movie.title = "movie test 1"
            movie.backdropImage = ""
            movie.genres_ids = []
            movie.overview = ""
            movie.posterImage = ""
            movie.releaseDate = NSDate()
            return movie
        }
    }
    
    var appCoordinator: AppCoordinator?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        guard let window = UIApplication.shared.keyWindow else {
            XCTAssert(false, "Bug: could not get app window")
            return
        }
        appCoordinator = AppCoordinator(window: window)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStartCoordinator() {
        appCoordinator?.start()
        guard let firstController = appCoordinator?.rootViewController.viewControllers.first else {
            XCTAssert(false, "Bug: could not reach first view controller")
            return
        }
        
        guard let _ = firstController as? TMDBListViewController else {
            XCTAssert(false, "Bug: not right view controller")
            return
        }
    }
    
    func testShowDetail() {
        appCoordinator?.showDetail(movie: movieTestOne)
        
        guard let currentController = appCoordinator?.rootViewController.visibleViewController else {
            XCTAssert(false, "Bug: could not reach current view controller")
            return
        }
        
        guard let _ = currentController as? TMDBDetailViewController else {
            XCTAssert(false, "Bug: not right view controller")
            return
        }
    }
}
