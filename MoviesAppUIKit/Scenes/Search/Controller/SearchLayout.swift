//
//  SearchLayout.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 06/10/2023.
//

import Foundation
import UIKit

extension SearchController {
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)
        
        let width = view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right
        let groupWidth: CGFloat = 180
        let itemLeading = item.contentInsets.leading
        let itemTrailing = item.contentInsets.trailing
        let subitems: Int = Int(width / (groupWidth + itemLeading + itemTrailing))
        let sideInset = (width - (groupWidth + itemLeading + itemTrailing) * CGFloat(subitems)) / 2
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(groupWidth),
            heightDimension: .absolute(390))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: subitems)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sideInset, bottom: 0, trailing: sideInset)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
