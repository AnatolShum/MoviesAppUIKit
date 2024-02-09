//  FavouriteManager.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 11/09/2023.

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ProtocolFavouriteManager: AnyObject {
    var delegate: ProtocolIsFavourites? { get set }
    func checkFavourite()
    func toggleFavourites()
}

class FavouriteManager: ProtocolFavouriteManager {
    let movie: Movie
    init(movie: Movie) {
        self.movie = movie
    }
    
    weak var delegate: ProtocolIsFavourites?
    
    func checkFavourite() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        guard let movieID = movie.id else { return }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .collection("favourites")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    let exist = querySnapshot!.documents.first { document in
                        movieID == document.data().filter({ $0.key == "movieID" }).values.first as? Int
                    }
                    if exist != nil {
                        self.delegate?.isFavourite = true
                    } else {
                        self.delegate?.isFavourite = false
                    }
                }
            }
    }
    
    func toggleFavourites() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        guard let movieID = movie.id else { return }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .collection("favourites")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    let exist = querySnapshot!.documents.first { document in
                        movieID == document.data().filter({ $0.key == "movieID" }).values.first as? Int
                    }
                    if exist != nil {
                        if let dbID = exist?.data().filter({ $0.key == "id" }).values.first {
                            self.deleteMovie(dbID: dbID as? String ?? "", userID: userID)
                        }
                    } else {
                        self.addMovie(movieID: movieID, userID: userID)
                    }
                }
            }
    }
    
    private func addMovie(movieID: Int, userID: String) {
        let newID = UUID().uuidString
        let newFavourite = Favourite(
            id: newID,
            movieID: movieID)
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .collection("favourites")
            .document(newID)
            .setData(newFavourite.asDictionary())
    }
    
    private func deleteMovie(dbID: String, userID: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .collection("favourites")
            .document(dbID)
            .delete()
    }
}
