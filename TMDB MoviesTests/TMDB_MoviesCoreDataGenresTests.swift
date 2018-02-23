//
//  TMDB_MoviesCoreDataGenresTests.swift
//  TMDB MoviesTests
//
//  Created by Augusto Ramalho Ramos on 23/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import XCTest
@testable import TMDB_Movies

class TMDB_MoviesCoreDataGenresTests: XCTestCase {
    
    var genreTestOne: Genre {
        get {
            let genre = Genre.mock()
            genre.id = 1
            genre.name = "genre test 1"
            return genre
        }
    }
    
    var genreTestTwo: Genre {
        get {
            let genre = Genre.mock()
            genre.id = 2
            genre.name = "genre test 2"
            return genre
        }
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadFavorites() {
        let dataManager = DataManager.shared
        dataManager.save(genres: [genreTestOne])
        let genres = dataManager.loadGenres()
        XCTAssert(genres.count >= 0, "Bug: DataManager+Genre - loadGenres() ")
    }
    
    func testFindGenreById() {
        let dataManager = DataManager.shared
        let genre = dataManager.findGenre(by: 1)
        XCTAssert(genre != nil, "could not find genre")
    }
    
    func testCustomGenresNames() {
        let dataManager = DataManager.shared
        dataManager.save(genres: [genreTestTwo])
        let customNames = dataManager.getGenres(ids: [Int16(genreTestOne.id), Int16(genreTestTwo.id)],
                                                joinedBy: ",")
        XCTAssert(customNames == "\(genreTestOne.name),\(genreTestTwo.name)",
                  "could not find genre")
    }
}
