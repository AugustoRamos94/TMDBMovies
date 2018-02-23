//
//  ImageView+Extension.swift
//  TMDB Movies
//
//  Created by Augusto Ramos on 22/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import UIKit

extension UIImageView {
    static var placeholderImage: UIImage {
        return UIImage(named: "placeholder")!
    }
    
    func setImage(url: URL,
                  placeholder: UIImage) {
        let imageCache = TMDBImageCache.shared.imageCache
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            image = cachedImage
        } else {
            image = placeholder
            TMDBServiceAPI().request(url,
                                     completion: {[weak self] (data, error) in
                                        if let data = data {
                                            DispatchQueue.main.async {
                                                if let image = UIImage(data: data) {
                                                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                                                    self?.image = image
                                                }
                                            }
                                        }
            })
        }
    }
}
