//
//  Genre+CoreDataClass.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//
//

import Foundation
import CoreData


public class Genre: NSManagedObject, Decodable {
    //MARK - Decodable initilizer
    
    public required convenience init(from decoder: Decoder) throws {
        let dataManager = DataManager.shared
        
        guard let description = NSEntityDescription.entity(forEntityName: "Genre", in: dataManager.context) else {
            fatalError("Failed to decode Genre =/")
        }
        self.init(entity: description, insertInto: nil)
        
        enum CodingKeys : String, CodingKey {
            case id = "id"
            case name = "name"
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}
