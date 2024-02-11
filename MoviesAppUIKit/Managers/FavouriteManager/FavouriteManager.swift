//  FavouriteManager.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 11/09/2023.

import Foundation
import Combine

class FavouriteManager: ProtocolFavouriteManager {
    let movie: Movie
    init(movie: Movie) {
        self.movie = movie
    }
    
    private var firestoreService: FirestoreService?
    private var subscribers: [AnyCancellable] = []
    weak var delegate: ProtocolIsFavourites?
    
    func checkFavourite() {
        guard let movieID = movie.id else { return }
        firestoreService = FirestoreService()
        firestoreService?.checkFavourite(movieID: movieID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard self != nil else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] favourite in
                guard let strongSelf = self else { return }
                if favourite {
                    strongSelf.delegate?.isFavourite = true
                } else {
                    strongSelf.delegate?.isFavourite = false
                }
            })
            .store(in: &subscribers)
    }
    
    func toggleFavourites() {
        guard let movieID = movie.id else { return }
        firestoreService = FirestoreService()
        firestoreService?.toggleFavourites(movieID: movieID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: {})
            .store(in: &subscribers)
    }
    
}
