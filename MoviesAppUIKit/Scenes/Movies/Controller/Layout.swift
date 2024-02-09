//
//  Layout.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 03/10/2023.
//

import Foundation
import UIKit

extension MoviesController {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]
            
            let headerItemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(30))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerItemSize,
                elementKind: SupplementaryViewKind.header,
                alignment: .top)
            
            switch section {
            case .nowPlaying:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 5,
                    bottom: 0,
                    trailing: 5)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(180),
                    heightDimension: .absolute(390))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 10,
                    leading: 0,
                    bottom: 10,
                    trailing: 0)
                section.boundarySupplementaryItems = [headerItem]
                
                return section
            case .topRated:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 5,
                    bottom: 0,
                    trailing: 5)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(180),
                    heightDimension: .absolute(390))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 10,
                    leading: 0,
                    bottom: 10,
                    trailing: 0)
                section.boundarySupplementaryItems = [headerItem]
                
                return section
            case .popular:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 5,
                    bottom: 0,
                    trailing: 5)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(180),
                    heightDimension: .absolute(390))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 10,
                    leading: 0,
                    bottom: 10,
                    trailing: 0)
                section.boundarySupplementaryItems = [headerItem]
                
                return section
            }
        }
        
        return layout
    }
}
