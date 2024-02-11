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
    
    func sendEmailVerification() -> Future<Void, Error> {
        return provider.sendEmailVerification()
    }
    
    func sendPasswordReset(email: String) -> Future<Void, Error> {
        return provider.sendPasswordReset(email: email)
    }
}
