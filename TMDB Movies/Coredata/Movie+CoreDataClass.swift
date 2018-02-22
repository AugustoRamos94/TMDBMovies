//
//  Movie+CoreDataClass.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//
//

import Foundation
import CoreData


public class Movie: NSManagedObject, Decodable {
    //MARK - Decodable initilizer
    
    public required convenience init(from decoder: Decoder) throws {
        let dataManager = DataManager()
        
        guard let description = NSEntityDescription.entity(forEntityName: "Movie", in: dataManager.context) else {
            fatalError("Failed to decode Movie =/")
        }
        self.init(entity: description, insertInto: nil)
        
        enum CodingKeys : String, CodingKey {
            case id = "id"
            case overview = "overview"
            case releaseDate = "release_date"
            case title = "title"
            case genres = "genre_ids"
            case backdropImage = "backdrop_path"
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        backdropImage = try container.decode(String?.self, forKey: .backdropImage)
        overview = try container.decode(String?.self, forKey: .overview)
        let strDate = try container.decode(String?.self, forKey: .releaseDate) ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        releaseDate = (dateFormatter.date(from: strDate) as! NSDate)
        title = try container.decode(String?.self, forKey: .title)
        genres_ids = try container.decode([Int16].self, forKey: .genres)
    }
}
