//
//  Movie+CoreDataProperties.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var backdropImage: String?
    @NSManaged public var id: Int16
    @NSManaged public var overview: String?
    @NSManaged public var releaseDate: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var genre: Int16

}
