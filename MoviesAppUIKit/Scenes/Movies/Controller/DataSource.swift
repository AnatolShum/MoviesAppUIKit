//
//  DataSource.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 03/10/2023.
//

import UIKit

extension MoviesController {
    func configureDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let section = self.sections[indexPath.section]
            
            switch section {
            case .nowPlaying:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell
                
                cell?.configureCell(with: item.nowPlaying!)
                
                return cell
            case .topRated:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell
                
                cell?.configureCell(with: item.topRated!)
  
                return cell
            case .popular:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell
                
                cell?.configureCell(with: item.popular!)
           
                return cell
            }
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, _, indexPath) -> UICollectionReusableView? in
            let section = self.sections[indexPath.section]
            let sectionName: String
            
            switch section {
            case .nowPlaying:
                sectionName = "Now playing"
            case .topRated:
                sectionName = "Top rated"
            case .popular:
                sectionName = "Popular"
            }
            
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: SupplementaryViewKind.header,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath) as? HeaderView
            headerView?.setTitle(sectionName)
            
            return headerView
        }
    }
    
    func applyDataSource() {
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
