//
//  TMDB_MoviesRequestsTests.swift
//  TMDB MoviesTests
//
//  Created by Augusto Ramalho Ramos on 23/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import XCTest
@testable import TMDB_Movies

class TMDB_MoviesRequestsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    var movies: [Movie]?
    func testGetParsedMovies() {
        let request = TMDBRequests(with: .upcoming)
        XCTAssert(request.page == 1, "page is not 1")
        
        request.run { (movies, error) in
            self.movies = movies
        }
        
        let pred = NSPredicate(format: "movies != nil")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 50)
        if res == XCTWaiter.Result.completed {
            guard let _ = movies else {
                XCTAssert(false, "movies is nil")
                return
            }
        } else {
            XCTAssert(false, "Bug")
        }
    }
    
    func testGetSearchParsedMovies() {
        let request = TMDBRequests(with: .search("Black"))
        XCTAssert(request.page == 1, "page is not 1")
        
        request.run { (movies, error) in
            self.movies = movies
        }
        
        let pred = NSPredicate(format: "movies != nil")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 50)
        if res == XCTWaiter.Result.completed {
            guard let _ = movies else {
                XCTAssert(false, "movies is nil")
                return
            }
        } else {
            XCTAssert(false, "Bug")
        }
    }
    
    var genres: [Genre]?
    func testGetParsedGenres() {
        TMDBRequests.genres { (genres, error) in
            self.genres = genres
        }
        
        let pred = NSPredicate(format: "genres != nil")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 50)
        if res == XCTWaiter.Result.completed {
            guard genres != nil else {
                XCTAssert(false, "genres is nil")
                return
            }
        } else {
            XCTAssert(false, "Bug")
        }
    }
}
