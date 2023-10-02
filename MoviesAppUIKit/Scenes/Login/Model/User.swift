//
//  User.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
