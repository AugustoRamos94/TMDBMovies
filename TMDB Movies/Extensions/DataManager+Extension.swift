//
//  DataManager+Extension.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 21/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation
import CoreData

extension DataManager {
    //MARK: Delete
    
    func delete(objects: [NSManagedObject]) {
        objects.forEach({
            context.delete($0)
        })
    }
    
    //MARK: Save
    
    func save(genres: [Genre]) {
        guard let description = NSEntityDescription.entity(forEntityName: "Genre", in: context) else {
            fatalError("Failed to decode Genre =/")
        }
        genres.forEach { (genre) in
            if genre.managedObjectContext != context {
                let genreToBeSaved = Genre(entity: description, insertInto: context)
                genreToBeSaved.id = genre.id
                genreToBeSaved.name = genre.name
            }
        }
        
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        saveContext()
    }
    
    func save(movies: [Movie]) {
        guard let description = NSEntityDescription.entity(forEntityName: "Movie", in: context) else {
            fatalError("Failed to decode Movie =/")
        }
        movies.forEach { (movie) in
            if movie.managedObjectContext != context {
                let movieToBeSaved = Movie(entity: description, insertInto: context)
                movieToBeSaved.id = movie.id
                movieToBeSaved.overview = movie.overview
                movieToBeSaved.releaseDate = movie.releaseDate
                movieToBeSaved.title = movie.title
                movieToBeSaved.genres_ids = movie.genres_ids
                movieToBeSaved.backdropImage = movie.backdropImage
                movieToBeSaved.posterImage = movie.posterImage
                context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                saveContext()
            }
        }
    }
    
    //MARK: Find
    
    func findGenre(by id: Int16) -> Genre? {
        let fetchRequest = Genre.fetchRequest() as NSFetchRequest<Genre>
        fetchRequest.predicate = NSPredicate(format: "id = %ld", id)
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Faild fetch request genre: \(error)")
            return nil
        }
    }
    
    func getGenres(ids: [Int16], joinedBy conc: String) -> String {
        let genres = ids
            .map({ findGenre(by: $0) })
            .flatMap({ $0?.name  })
        
        return genres.isEmpty ? "No genres" : genres.joined(separator: conc)
    }
    
    //MARK: Load
    
    func loadMovies() -> [Movie] {
        let fetchRequest = Movie.fetchRequest() as NSFetchRequest<Movie>
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Faild fetch request movies: \(error)")
            return []
        }
    }
    
    func loadGenres() -> [Genre] {
        let fetchRequest = Genre.fetchRequest() as NSFetchRequest<Genre>
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Faild fetch request genres: \(error)")
            return []
        }
    }
}
