//
//  IdentifierClassProtocol.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation
import UIKit

protocol IdentifierClassProtocol: class {
    static var identifier: String { get }
    static func nib()-> UINib
}

extension IdentifierClassProtocol {
    static var identifier: String { return "\(self)" }
    static func nib()-> UINib { return UINib(nibName: identifier, bundle: nil) }
}

