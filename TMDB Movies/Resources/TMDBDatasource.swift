//
//  TMDBDatasource.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation
import UIKit

class TMDBDatasource: NSObject {
    var items: [Movie] = []
}

extension TMDBDatasource: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMDBMovieCollectionViewCell.identifier, for: indexPath) as? TMDBMovieCollectionViewCell else {
            fatalError()
        }
        
        cell.model = items[indexPath.item]
        return cell
    }
}
