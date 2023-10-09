//
//  FetchFavourites.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 07/10/2023.
//

import Foundation

extension FavouritesController {
    func fetchFavourites(_ dbFavourites: [Favourite]) {
        movies = []
        dbFavourites.forEach { [weak self] favourite in
            guard let self = self else { return }
            Network.Client.shared.get(.movie(id: favourite.movieID)) { (result: Result<Network.Types.Response.MovieObject, Network.Errors>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let success):
                        let movie = Movie(title: success.title,
                                          id: success.id,
                                          backdrop: success.backdrop,
                                          poster: success.poster,
                                          releaseDate: success.releaseDate,
                                          overview: success.overview,
                                          vote: success.vote)
                        self.movies.append(movie)
                        
                        self.reloadData()
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
            }
        }
    }
}
