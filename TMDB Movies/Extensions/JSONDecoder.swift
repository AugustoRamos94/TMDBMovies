//
//  JSONDecoder.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    static func decode<T>(_ type: T.Type, from jsonString: String) -> T? where T : Decodable {
        let decoder = JSONDecoder()
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Failed when create jsonData")
            return nil
        }
        
        do {
            let obj = try decoder.decode(type, from: jsonData)
            return obj
        } catch {
            print(error)
            return nil
        }
    }
}
