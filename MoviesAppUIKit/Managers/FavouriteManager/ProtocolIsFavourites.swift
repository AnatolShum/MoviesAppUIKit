//
//  ProtocolIsFavourites.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 07/10/2023.
//

import Foundation

protocol ProtocolIsFavourites: AnyObject {
    var isFavourite: Bool { get set }
}

protocol ProtocolFavouriteManager: AnyObject {
    var delegate: ProtocolIsFavourites? { get set }
    func checkFavourite()
    func toggleFavourites()
}
