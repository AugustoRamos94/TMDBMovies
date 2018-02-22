//
//  String+Extension.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 22/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation

extension String {
    func dateFromFormat(_ format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: Calendar.Identifier.iso8601)
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
