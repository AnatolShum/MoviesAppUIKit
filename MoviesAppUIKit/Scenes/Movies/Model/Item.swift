//
//  Item.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 04/10/2023.
//

import Foundation

    enum Item: Hashable {
        case nowPlaying(Movie)
        case topRated(Movie)
        case popular(Movie)
        
        var nowPlaying: Movie? {
            if case .nowPlaying(let nowPlaying) = self {
                return nowPlaying
            } else {
                return nil
            }
        }
        
        var topRated: Movie? {
            if case .topRated(let topRated) = self {
                return topRated
            } else {
                return nil
            }
        }
        
        var popular: Movie? {
            if case .popular(let popular) = self {
                return popular
            } else {
                return nil
            }
        }
        
        static var nowPlayingMovies: [Item] = []
        static var topRatedMovies: [Item] = []
        static var popularMovies: [Item] = []
    }
