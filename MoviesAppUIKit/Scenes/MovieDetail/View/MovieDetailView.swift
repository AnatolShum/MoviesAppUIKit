//
//  MovieDetailView.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 04/10/2023.
//

import Foundation
import UIKit

class MovieDetailView: UIView {
    let navigationController: UINavigationController
    let movie: Movie
    var photos: [Photos] = []
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    let topImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    var hStack: UIStackView!
    
    let circularProgressView = CircularProgressView()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score"
        label.font = .systemFont(ofSize: 22)
        label.textColor = .white
        return label
    }()
    
    let spacerLabel: UILabel = {
        let label = UILabel()
        label.text = "|"
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    let trailerButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "play.fill")
        var attributedString = AttributedString("Trailer")
        attributedString.font = UIFont.boldSystemFont(ofSize: 22)
        configuration.attributedTitle = attributedString
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .clear
        configuration.imagePadding = 5
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    var vStack: UIStackView!
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        label.text = "Overview"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        return label
    }()
    
    let photosLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        label.text = "Photos"
        return label
    }()
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    var photosCollectionView: PhotosCollectionView!
      
    init(navigationController: UINavigationController, movie: Movie, frame: CGRect) {
        self.navigationController = navigationController
        self.movie = movie
        super.init(frame: frame)
        
        fetchImage()
        fetchPhotos()
        photosCollectionView = PhotosCollectionView(frame: bounds, collectionViewLayout: layout)
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        setupUI()
        setupData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupData() {
        titleLabel.text = movie.title
        yearLabel.text = formattedYear()
        descriptionLabel.text = movie.overview
    }
    
    private func fetchImage() {
        Task {
            do {
                let backdrop = try await Network.Client.shared.fetchImage(with: self.movie.backdrop)
                DispatchQueue.main.async {
                    self.topImageView.image = backdrop
                    self.backgroundColor = backdrop.averageColor()
                }
            } catch {
                DispatchQueue.main.async {
                    self.topImageView.image = UIImage(systemName: "film")
                }
                print(error.localizedDescription)
            }
        }
    }
    
}
