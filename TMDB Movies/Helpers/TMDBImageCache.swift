//
//  TMDBImageCache.swift
//  TMDB Movies
//
//  Created by Augusto Ramos on 22/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Singleton

final class TMDBImageCache {
    private init() { }
    
    // MARK: Shared Instance
    
    static let shared = TMDBImageCache()
    var imageCache = NSCache<NSString, UIImage>()
}
