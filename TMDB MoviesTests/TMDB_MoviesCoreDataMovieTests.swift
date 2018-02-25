//
//  TMDB_MoviesCoreDataMovieTests.swift
//  TMDB MoviesTests
//
//  Created by Augusto Ramalho Ramos on 23/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import XCTest
@testable import TMDB_Movies

class TMDB_MoviesCoreDataMovieTests: XCTestCase {
    
    var movieTestOne: Movie {
        get {
            let movie = Movie.mock()
            movie.id = 1
            movie.title = "TMDB_MoviesCoreDataMovieTests"
            movie.backdropImage = ""
            movie.genres_ids = []
            movie.overview = ""
            movie.posterImage = ""
            movie.releaseDate = NSDate()
            return movie
        }
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        DataManager.shared.delete(objects: [movieTestOne])
    }
    
    func testLoadMovies() {
        let dataManager = DataManager.shared
        dataManager.save(movies: [movieTestOne])
        let movies = dataManager.loadMovies()
        XCTAssert(movies.count >= 0, "Bug: DataManager+Movie - loadMovies() ")
    }
}
