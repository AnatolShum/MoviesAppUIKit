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
            return AuthUser(id: user.uid, isEmailVerified: user.isEmailVerified)
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
        return AuthUser(id: user.uid, isEmailVerified: user.isEmailVerified)
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
    
    
    //    // working func
    //    func createUser(email: String, password: String, completion: @escaping(Result<AuthUser?, Error>) -> Void) {
    //        Auth.auth().createUser(withEmail: email, password: password) { result, error in
    //            if let error {
    //                completion(.failure(error))
    //            }
    //
    //            if let result {
    //                let user = result.user
    //                completion(.success(AuthUser(
    //                    id: user.uid,
    //                    isEmailVerified: user.isEmailVerified
    //                )))
    //            }
    //        }
    //    }
}


//func createUser(email: String, password: String) -> Future<AuthUser?, Error> {
//    return Future() { promise in
//
//        Auth.auth().createUser(withEmail: email, password: password) { result, error in
//            if let error {
//                promise(.failure(error))
//            }
//
//            if let result {
//                let user = result.user
//                promise(.success(AuthUser(
//                    id: user.uid,
//                    isEmailVerified: user.isEmailVerified)))
//            }
//        }
//
//        promise(.success(AuthUser(id: "Test", isEmailVerified: true)))
//    }
//}
//
//let b = createUser(email: "", password: "").sink { er in
//    switch er {
//
//    case .finished:
//        print("Finished")
//    case .failure(let error):
//        print(error)
//    }
//} receiveValue: { user in
//    print(user?.id)
//}



