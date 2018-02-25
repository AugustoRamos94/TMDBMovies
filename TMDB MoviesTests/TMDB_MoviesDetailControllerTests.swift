//
//  TMDB_MoviesDetailControllerTests.swift
//  TMDB MoviesTests
//
//  Created by Augusto Ramalho Ramos on 23/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import XCTest
@testable import TMDB_Movies

class TMDB_MoviesDetailControllerTests: XCTestCase {
    
    var movieTest: Movie {
        get {
            let movie = Movie.mock()
            movie.id = 1
            movie.title = "TMDB_MoviesDetailControllerTests"
            movie.overview = "overview"
            movie.releaseDate = NSDate()
            movie.genres_ids = [10, 20]
            
            return movie
        }
    }
    
    var detailController: TMDBDetailViewController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let detailController = TMDBDetailViewController(with: movieTest)
        self.detailController = detailController
        guard self.detailController != nil else {
            XCTAssert(false, "Bug: not instantiate TMDBDetailViewController")
            return
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDetailController() {
        _ = detailController!.view
        detailController!.updateUI()
        XCTAssert(detailController!.labelTitle.text == movieTest.customTitle, "Bug: info not equal")
        XCTAssert(detailController!.labelReleaseDate.text == movieTest.customReleaseDate, "Bug: info not equal")
        XCTAssert(detailController!.labelOverview.text == movieTest.overview, "Bug: info not equal")
        XCTAssert(detailController!.labelGenre.text == DataManager.shared.getGenres(ids: movieTest.genres_ids, joinedBy: ", "), "Bug: info not equal")
        XCTAssert(detailController!.imageView.image == UIImageView.placeholderImage, "Bug: info not equal")
    }
}
