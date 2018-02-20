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
    var config: TMDBRequestEnum! {
        didSet {
            page = 1
        }
    }
    private var request = TMDBServiceAPI()
    
    //MARK: Init
    init() {
        config = .upcoming
    }
    
    convenience init(with config: TMDBRequestEnum) {
        self.init()
        self.config = config
    }
    
    //MARK: Request
    
    func run(_ completion: (([Movie]) -> Void)) {
        guard let url = config.url(for: page) else { return }
        request.request(url) { (data, error) in
            
        }
    }
}
