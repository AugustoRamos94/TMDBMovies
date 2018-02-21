//
//  TMDBMovieCollectionViewCell.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import UIKit

class TMDBMovieCollectionViewCell: UICollectionViewCell, IdentifierClassProtocol {
    var model: Movie! {
        didSet {
            populate()
        }
    }
    
    private func populate() {
        
    }
}
