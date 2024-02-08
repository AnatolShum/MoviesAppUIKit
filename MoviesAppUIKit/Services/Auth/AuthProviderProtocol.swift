//
//  AuthProviderProtocol.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 07.02.2024.
//

import Foundation
import Combine

protocol AuthProviderProtocol {
    var currentUser: AuthUser? { get }
    
    func signIn(email: String, password: String) -> Future<AuthUser?, Error>
    func createUser(email: String, password: String) -> Future<AuthUser?, Error>
    func signOut() -> Future<Void, Error>
    
//    // working func
//    func createUser(email: String, password: String, completion: @escaping(Result<AuthUser?, Error>) -> Void)
}
