//
//  FavouritesCellDelegate.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 09/10/2023.
//

import Foundation

extension FavouritesController: MovieCellDelegate {
    func reloadDataSource() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.getFavourites()
        }
    }
}
