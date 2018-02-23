//
//  APITest.swift
//  TMDB MoviesTests
//
//  Created by Augusto Ramalho Ramos on 23/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import XCTest
@testable import TMDB_Movies

class APITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    var dataRequest: Data?
    func testRequestsUpcomingMoviesAPIAndDecodeMovies() {
        let request = TMDBServiceAPI()
        let info = TMDBRequestEnum.Movie.upcoming.requestInfo()
        
        XCTAssert(info.url != nil, "url is nil")
        
        request.request(info.url!, method: info.method) { (data, error) in
            self.dataRequest = data
        }
        
        let pred = NSPredicate(format: "dataRequest != nil")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 50)
        if res == XCTWaiter.Result.completed {
            guard let dataRequest = dataRequest else {
                XCTAssert(false, "dataRequest is nil")
                return
            }
            
            //DECODE MOVIES
            guard let stringData = String(data: dataRequest, encoding: .utf8) else {
                XCTAssert(false, "stringData is nil")
                return
            }
            
            guard let response = JSONDecoder.decode(TMDBAPIResponse.self, from: stringData) else {
                XCTAssert(false, "Bug: decode movies")
                return 
            }
            
            XCTAssert(response.results.count == 20, "Bug: need 20 movies")
        } else {
            XCTAssert(false, "Bug")
        }
    }
    
    func testRequestsGenresMoviesAPIAndDecodeGenres() {
        let request = TMDBServiceAPI()
        let info = TMDBRequestEnum.Genre.movie.requestInfo()
        
        XCTAssert(info.url != nil, "url is nil")
        
        request.request(info.url!, method: info.method) { (data, error) in
            self.dataRequest = data
        }
        
        let pred = NSPredicate(format: "dataRequest != nil")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 50)
        if res == XCTWaiter.Result.completed {
            guard let dataRequest = dataRequest else {
                XCTAssert(false, "dataRequest is nil")
                return
            }
            
            //DECODE MOVIES
            guard let stringData = String(data: dataRequest, encoding: .utf8) else {
                XCTAssert(false, "stringData is nil")
                return
            }
            
            guard let response = JSONDecoder.decode([String: [Genre]].self, from: stringData) else {
                XCTAssert(false, "Bug: decode genres")
                return
            }
            
            guard let _ = response["genres"] else {
                XCTAssert(false, "Bug: could not access genres")
                return
            }
        } else {
            XCTAssert(false, "Bug")
        }
    }
}
