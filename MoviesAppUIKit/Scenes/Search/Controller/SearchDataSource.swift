//
//  SearchDataSource.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 06/10/2023.
//

import Foundation
import UIKit

extension SearchController {
    func configureDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
            
            cell.configureCell(with: item)
            
            return cell
        })
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
