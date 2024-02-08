//
//  AuthService.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 07.02.2024.
//

import Foundation
import Combine

class AuthService: AuthProviderProtocol {
    
    private let provider: AuthProviderProtocol
    
    init() {
        self.provider = AuthProvider()
    }
    
    var currentUser: AuthUser? {
        return provider.currentUser
    }
    
    func signIn(email: String, password: String) -> Future<AuthUser?, Error> {
        return provider.signIn(email: email, password: password)
    }
    
    func createUser(email: String, password: String) -> Future<AuthUser?, Error> {
        return provider.createUser(email: email, password: password)
    }
    
    func signOut() -> Future<Void, Error> {
        return provider.signOut()
    }
    
    
//    // working func
//    func createUser(email: String, password: String, completion: @escaping (Result<AuthUser?, Error>) -> Void) {
//        provider.createUser(email: email, password: password) { result in
//            switch result {
//            case .success(let user):
//                completion(.success(user))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
}
