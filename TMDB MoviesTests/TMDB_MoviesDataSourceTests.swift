//
//  TMDB_MoviesDataSourceTests.swift
//  TMDB MoviesTests
//
//  Created by Augusto Ramos on 23/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import XCTest
@testable import TMDB_Movies

class TMDB_MoviesDataSourceTests: XCTestCase {
    var movieTestOne: Movie {
        get {
            let movie = Movie.mock()
            movie.id = 1
            movie.title = "TMDB_MoviesDataSourceTests 1"
            movie.backdropImage = ""
            movie.genres_ids = []
            movie.overview = ""
            movie.posterImage = ""
            movie.releaseDate = NSDate()
            return movie
        }
    }
    
    var datasource: TMDBDatasource?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        datasource = TMDBDatasource()
        XCTAssertTrue(datasource != nil, "Bug: did not instantiate datasource")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataSourceItems() {
        datasource?.items = [movieTestOne]
        XCTAssertTrue(datasource?.items.count == 1, "Bug: did not include items")
    }
    
}
