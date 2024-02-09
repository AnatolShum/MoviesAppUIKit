//
//  PhotosCell.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 04/10/2023.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    static let reuseIdentifier = "PhotosCell"
    
    let photoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "film")
        image.tintColor = .systemGray.withAlphaComponent(0.5)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leftAnchor.constraint(equalTo: leftAnchor),
            photoImageView.rightAnchor.constraint(equalTo: rightAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchImage(with path: String?) {
        Task {
            do {
                let photo = try await Network.Client.shared.fetchImage(with: path)
                DispatchQueue.main.async {
                    self.photoImageView.image = photo
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
