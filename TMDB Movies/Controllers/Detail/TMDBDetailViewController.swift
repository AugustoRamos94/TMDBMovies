//
//  TMDBDetailViewController.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 21/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import UIKit

class TMDBDetailViewController: UIViewController {
    //MARK: IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var scrollContent: UIScrollView!
    @IBOutlet weak var stackContent: UIStackView!
    
    
    //MARK: Properties
    
    private var movie: Movie!
    
    //MARK: Init
    
    convenience init(with movie: Movie) {
        self.init()
        self.movie = movie
    }
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        updateUI()
    }
    
    private func updateUI() {
        labelTitle.text = movie.title
        labelGenre.text = DataManager().getGenres(ids: movie.genres_ids, joinedBy: ", ")
        labelOverview.text = movie.overview
        
        if let date = movie.releaseDate as Date? {
            labelReleaseDate?.text = date.stringFromFormat("EEE, MM-dd-yyyy")
        }
        
        imageView.image = UIImage(named: "placeholder")
    }
}
