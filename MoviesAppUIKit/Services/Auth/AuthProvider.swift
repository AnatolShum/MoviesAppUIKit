//
//  AuthProvider.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 07.02.2024.
//

import Foundation
import FirebaseAuth
import Combine

internal class AuthProvider: AuthProviderProtocol {
    var currentUser: AuthUser? {
        let user = Auth.auth().currentUser
        if let user {
            let authUser = AuthUser(
                id: user.uid,
                email: user.email ?? "N/A",
                isEmailVerified: user.isEmailVerified)
            return authUser
        } else {
            return nil
        }
    }
    
    func signIn(email: String, password: String) -> Future<AuthUser?, Error> {
        return Future { promise in
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                if let error {
                    promise(.failure(error))
                }
                if let result {
                    let user = self?.convertUser(result)
                    promise(.success(user))
                }
            }
        }
    }
    
    
    func createUser(email: String, password: String) -> Future<AuthUser?, Error> {
        return Future { promise in
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                if let error {
                    promise(.failure(error))
                }
                
                if let result {
                    let user = self?.convertUser(result)
                    promise(.success(user))
                }
            }
        }
    }
    
    private func convertUser(_ result: AuthDataResult) -> AuthUser {
        let user = result.user
        return AuthUser(id: user.uid, email: user.email ?? "N/A", isEmailVerified: user.isEmailVerified)
    }
    
    func signOut() -> Future<Void, Error> {
        return Future { promise in
            do {
                try Auth.auth().signOut()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
    }
    
    func sendEmailVerification() -> Future<Void, Error> {
        return Future { promise in
            Auth.auth().currentUser?.sendEmailVerification(completion: { error in
                if let error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            })
        }
    }
    
    func sendPasswordReset(email: String) -> Future<Void, Error> {
        return Future { promise in
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
    }
    
}
