//
//  Date+Extension.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 22/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation

extension Date {
    func stringFromFormat(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = .current
        return dateFormatter.string(from: self)
    }
}
