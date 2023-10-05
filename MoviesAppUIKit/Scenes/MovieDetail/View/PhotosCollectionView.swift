//
//  PhotosCollectionView.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 04/10/2023.
//

import Foundation
import UIKit

class PhotosCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.reuseIdentifier)
        backgroundColor = .clear
        isPagingEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
