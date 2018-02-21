//
//  TMDBDetailViewController.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 21/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import UIKit

class TMDBDetailViewController: UIViewController {
    //MARK: Properties
    
    private var movie: Movie!
    
    //MARK: Init
    
    convenience init(with movie: Movie) {
        self.init()
        self.movie = movie
    }
}
