//
//  FetchMovies.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 04/10/2023.
//

import Foundation

extension MoviesController {
    func fetchNowPlaying(with page: Int) {
        Network.Client.shared.get(.nowPlaying(page: page)) { [weak self] (result: Result<Network.Types.Response.MovieResults, Network.Errors>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    success.results.forEach { movie in
                        if !Item.nowPlayingMovies.contains(.nowPlaying(movie)) {
                            Item.nowPlayingMovies.append(.nowPlaying(movie))
                        }
                    }
                    self.applyDataSource()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchTopRated(with page: Int) {
        Network.Client.shared.get(.topRated(page: page)) { [weak self] (result: Result<Network.Types.Response.MovieResults, Network.Errors>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    success.results.forEach { movie in
                        if !Item.topRatedMovies.contains(.topRated(movie)) {
                            Item.topRatedMovies.append(.topRated(movie))
                        }
                    }
                    self.applyDataSource()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchPopular(with page: Int) {
        Network.Client.shared.get(.popular(page: page)) { [weak self] (result: Result<Network.Types.Response.MovieResults, Network.Errors>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    success.results.forEach { movie in
                        if !Item.popularMovies.contains(.popular(movie)) {
                            Item.popularMovies.append(.popular(movie))
                        }
                    }
                    self.applyDataSource()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func applyDataSource() {
        snapshot.deleteSections([.nowPlaying, .topRated, .popular])
        snapshot.deleteAllItems()
        
        snapshot.appendSections([.nowPlaying, .topRated, .popular])
        snapshot.appendItems(Item.nowPlayingMovies, toSection: .nowPlaying)
        snapshot.appendItems(Item.topRatedMovies, toSection: .topRated)
        snapshot.appendItems(Item.popularMovies, toSection: .popular)
        sections = snapshot.sectionIdentifiers
        dataSource.apply(snapshot)
    }
}
