//
//  TMDBRequests.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation

class TMDBRequests {
    //MARK: Properties
    var page: Int = 1
    var config: TMDBRequestEnum!
    
    //MARK: Init
    init() {
        config = .upcoming
    }
    
    convenience init(with config: TMDBRequestEnum) {
        self.init()
        self.config = config
    }
    
    //MARK: Request
    
    func run() {
        
    }
}
