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
    
    @IBOutlet weak var imageBackdrop: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelGenres: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    
    //MARK: Model
    
    var model: Movie! {
        didSet { populate() }
    }
    
    //MARK: Populate
    
    private func populate() {
        labelTitle?.text = model.customTitle
        if let url = TMDBImageRequestEnum.Backdrop.w300.url(for: model.backdropImage) {
            imageBackdrop.setImage(url: url,
                placeholder: UIImageView.placeholderImage)
        } else {
            imageBackdrop.image = UIImageView.placeholderImage
        }
        labelGenres.text = DataManager.shared.getGenres(ids: model.genres_ids, joinedBy: ", ")
        labelReleaseDate?.text = model.customReleaseDate
    }
}
