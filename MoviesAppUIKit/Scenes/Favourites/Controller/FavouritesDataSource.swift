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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell
            
            cell?.delegate = self
            cell?.configureCell(with: item)
            
            return cell
        })
        
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func reloadData() {
        snapshot.deleteAllItems()
        snapshot.deleteSections([.main])
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
