//
//  TMDBMovieCollectionViewCell.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import UIKit

class TMDBMovieCollectionViewCell: UICollectionViewCell, IdentifierClassProtocol {
    //MARK: IBOutlets
    
    @IBOutlet weak var labelTitle: UILabel!
    
    //MARK: Model
    
    var model: Movie! {
        didSet {
            populate()
        }
    }
    
    //MARK: Populate
    
    private func populate() {
        labelTitle?.text = model.title
    }
}
