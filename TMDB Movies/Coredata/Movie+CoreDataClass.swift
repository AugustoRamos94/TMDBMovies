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
    var customTitle: String {
        return title.isEmpty ? "No title" : title
    }
    
    var customReleaseDate: String {
        return (releaseDate as Date).stringFromFormat("EEE, MM-dd-yyyy")
    }
    
    //MARK - Decodable initilizer
    
    public required convenience init(from decoder: Decoder) throws {
        let dataManager = DataManager.shared
        
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
            case posterImage = "poster_path"
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        backdropImage = try container.decode(String?.self, forKey: .backdropImage) ?? ""
        posterImage = try container.decode(String?.self, forKey: .posterImage) ?? ""
        overview = try container.decode(String?.self, forKey: .overview) ?? ""
        let strDate = try container.decode(String?.self, forKey: .releaseDate) ?? ""
        releaseDate = (strDate.dateFromFormat("yyyy-mm-dd") as NSDate?) ?? NSDate()
        title = try container.decode(String?.self, forKey: .title) ?? ""
        genres_ids = try container.decode([Int16]?.self, forKey: .genres) ?? []
    }
    
    //MARK - internal
    
    internal class func mock() -> Movie {
        let dataManager = DataManager.shared
        guard let description = NSEntityDescription.entity(forEntityName: "Movie", in: dataManager.context) else {
            fatalError("Failed to generate Movie mock =/")
        }
        return Movie(entity: description, insertInto: nil)
    }
}
