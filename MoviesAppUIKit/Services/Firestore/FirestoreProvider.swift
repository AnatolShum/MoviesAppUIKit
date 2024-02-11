//
//  FirestoreProvider.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 11.02.2024.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

class FirestoreProvider: FirestoreProviderProtocol {
    func setUser(user: User) -> Future<Void, Error> {
        return Future { [weak self] promise in
            guard let strongSelf = self else { return }
            let db = Firestore.firestore()
            db.collection("users")
                .document(user.id)
                .setData(user.asDictionary()) { error in
                    if let error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
        }
    }
    
    func getUser() -> Future<User, Error> {
        return Future { [weak self] promise in
            guard let strongSelf = self else { return }
            let authService = AuthService()
            guard let user = authService.currentUser else { return }
            let userID = user.id
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(userID)
                .getDocument { documentSnapshot, error in
                    if let error {
                        promise(.failure(error))
                    }
                    if let data = documentSnapshot?.data() {
                        let user = User(
                            id: data["id"] as? String ?? "Data error",
                            name: data["name"] as? String ?? "Data error",
                            email: data["email"] as? String ?? "Data error",
                            joined: data["joined"] as? TimeInterval ?? 0
                        )
                        promise(.success(user))
                    }
                }
        }
    }
    
    func getFafourites() -> Future<[Favourite], Error> {
        return Future { [weak self] promise in
            guard let strongSelf = self else { return }
            strongSelf.getFavourites { result in
                switch result {
                case .success(let favourites):
                    promise(.success(favourites))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    private func getFavourites(completion: @escaping (Result<[Favourite], Error>) -> Void) {
        let authService = AuthService()
        let user = authService.currentUser
        guard let userID = user?.id else { return }
        var favourites: [Favourite] = []
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .collection("favourites")
            .getDocuments { querySnapshot, error in
                if let error {
                    completion(.failure(error))
                }
                if let documents = querySnapshot?.documents {
                    documents.forEach { document in
                        let data = document.data()
                        let favourite = Favourite(
                            id: data["id"] as? String ?? "",
                            movieID: data["movieID"] as? Int ?? 0
                        )
                        favourites.append(favourite)
                    }
                    completion(.success(favourites))
                }
            }
    }
    
    func checkFavourite(movieID: Int) -> Future<Bool, Error> {
        return Future { [weak self] promise in
            guard let strongSelf = self else { return }
            strongSelf.checkFavourite(movieID: movieID) { result in
                switch result {
                case .success(let exist):
                    if let exist {
                        promise(.success(true))
                    } else {
                        promise(.success(false))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    private func checkFavourite(movieID: Int, completion: @escaping (Result<Favourite?, Error>) -> Void) {
        getFavourites { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let favourites):
                let exist = favourites.first { $0.movieID == movieID }
                if let exist {
                    completion(.success(exist))
                } else {
                    completion(.success(nil))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func addFavourite(movieID: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let newID = UUID().uuidString
        let newFavourite = Favourite(
            id: newID,
            movieID: movieID
        )
        let authService = AuthService()
        let user = authService.currentUser
        let userID = user?.id
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID ?? "")
            .collection("favourites")
            .document(newID)
            .setData(newFavourite.asDictionary()) { error in
                if let error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
    
    private func deleteFavourite(favouriteID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let authService = AuthService()
        let user = authService.currentUser
        let userID = user?.id
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID ?? "")
            .collection("favourites")
            .document(favouriteID)
            .delete { error in
                if let error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        
    }
    
    func toggleFavourites(movieID: Int) -> Future<Void, Error> {
        return Future { [weak self] promise in
            guard let strongSelf = self else { return }
            strongSelf.checkFavourite(movieID: movieID) { result in
                switch result {
                case .success(let favourite):
                    if let favourite {
                        strongSelf.deleteFavourite(favouriteID: favourite.id) { result in
                            switch result {
                            case .success(()):
                                promise(.success(()))
                            case .failure(let error):
                                promise(.failure(error))
                            }
                        }
                    } else {
                        strongSelf.addFavourite(movieID: movieID) { result in
                            switch result {
                            case .success(()):
                                promise(.success(()))
                            case .failure(let error):
                                promise(.failure(error))
                            }
                        }
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
}
