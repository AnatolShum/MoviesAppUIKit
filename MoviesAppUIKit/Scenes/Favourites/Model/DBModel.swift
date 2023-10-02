//
//  DBModel.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 11/09/2023.
//

import Foundation

struct Favourite: Codable, Identifiable {
    let id: String
    let movieID: Int
}
