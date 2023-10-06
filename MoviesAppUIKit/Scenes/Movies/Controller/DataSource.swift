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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
                
                cell.configureCell(title: item.nowPlaying?.title, releaseDate: item.nowPlaying?.releaseDate, vote: item.nowPlaying?.vote, poster: item.nowPlaying?.poster)
                
                return cell
            case .topRated:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
                
                cell.configureCell(title: item.topRated?.title, releaseDate: item.topRated?.releaseDate, vote: item.topRated?.vote, poster: item.topRated?.poster)
  
                return cell
            case .popular:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
                
                cell.configureCell(title: item.popular?.title, releaseDate: item.popular?.releaseDate, vote: item.popular?.vote, poster: item.popular?.poster)
           
                return cell
            }
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
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
                for: indexPath) as! HeaderView
            headerView.setTitle(sectionName)
            
            return headerView
        }
    }
}
