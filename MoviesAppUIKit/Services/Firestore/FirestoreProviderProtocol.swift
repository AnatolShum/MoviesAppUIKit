//
//  FirestoreProviderProtocol.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 11.02.2024.
//

import Foundation
import Combine

protocol FirestoreProviderProtocol {
    func getUser() -> Future<User, Error>
    func setUser(user: User) -> Future<Void, Error>
    func getFafourites() -> Future<[Favourite], Error>
    func checkFavourite(movieID: Int) -> Future<Bool, Error>
    func toggleFavourites(movieID: Int) -> Future<Void, Error>
}
