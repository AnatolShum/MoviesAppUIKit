//
//  SearchResultUpdating.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 06/10/2023.
//

import Foundation
import UIKit

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchingString = searchController.searchBar.text, !searchingString.isEmpty {
            fetchMovies(with: searchingString)
        } else {
            movies = []
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
