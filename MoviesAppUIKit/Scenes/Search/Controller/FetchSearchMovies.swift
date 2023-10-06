//
//  FetchSearchMovies.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 06/10/2023.
//

import Foundation

extension SearchController {
    func fetchMovies(with searchText: String) {
        Network.Client.shared.get(.search(query: searchText)) { [weak self] (result: Result<Network.Types.Response.MovieResults, Network.Errors>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.movies = success.results
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }
}
