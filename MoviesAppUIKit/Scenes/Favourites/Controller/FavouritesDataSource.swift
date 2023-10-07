//
//  FavouritesDataSource.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 07/10/2023.
//

import Foundation
import UIKit

extension FavouritesController {
    func configureDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
            
            cell.configureCell(title: item.title, releaseDate: item.releaseDate, vote: item.vote, poster: item.poster)
            
            return cell
        })
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
