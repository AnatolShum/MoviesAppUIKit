//
//  FirestoreService.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 11.02.2024.
//

import Foundation
import Combine

class FirestoreService: FirestoreProviderProtocol {
    private let provider: FirestoreProviderProtocol
    
    init() {
        self.provider = FirestoreProvider()
    }
    
    func setUser(user: User) -> Future<Void, Error> {
        return provider.setUser(user: user)
    }
    
    func getUser() -> Future<User, Error> {
        return provider.getUser()
    }
    
    func getFafourites() -> Future<[Favourite], Error> {
        return provider.getFafourites()
    }
    
    func checkFavourite(movieID: Int) -> Future<Bool, Error> {
        return provider.checkFavourite(movieID: movieID)
    }
    
    func toggleFavourites(movieID: Int) -> Future<Void, Error> {
        return provider.toggleFavourites(movieID: movieID)
    }
}
