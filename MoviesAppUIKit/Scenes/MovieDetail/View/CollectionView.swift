//
//  CollectionView.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 05/10/2023.
//

import Foundation
import UIKit

extension MovieDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            photos.count
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseIdentifier, for: indexPath) as! PhotosCell
    
            let item = photos[indexPath.item]
            cell.fetchImage(with: item.path)
            
            return cell
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 160, height: 100)
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = photos[indexPath.item]
        let fullScreenController = FullScreenImageController(paths: photos, path: item.path)
        navigationController.pushViewController(fullScreenController, animated: true)
    }
    
        func fetchPhotos() {
            Network.Client.shared.get(.photos(id: movie.id)) { [weak self] (result: Result<Network.Types.Response.Backdrops, Network.Errors>) in
                guard let self = self else { return }
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.photos = success.backdrops
                        self.photosCollectionView.reloadData()
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
}
