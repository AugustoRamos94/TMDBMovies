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
    }
}
