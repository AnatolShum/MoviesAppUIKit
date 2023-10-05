//
//  MovieCell.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 03/10/2023.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let reuseIdentifier = "MovieCell"
    
    let movieImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let favouritesButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "heart", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .systemPink.withAlphaComponent(0.6)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var circleProgressView = CircularProgressView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.backgroundColor = .black.withAlphaComponent(0.9)
        createUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        addSubview(movieImageView)
        movieImageView.addSubview(favouritesButton)
        addSubview(circleProgressView)
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leftAnchor.constraint(equalTo: leftAnchor),
            movieImageView.rightAnchor.constraint(equalTo: rightAnchor),
            favouritesButton.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 10),
            favouritesButton.leftAnchor.constraint(equalTo: movieImageView.leftAnchor, constant: 15),
            circleProgressView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10),
            circleProgressView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 50),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            releaseDateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            releaseDateLabel.rightAnchor.constraint(equalTo: rightAnchor),
            releaseDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func configureCell(title: String?, releaseDate: String?, vote: Double?, poster: String?) {
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
        circleProgressView.progressAnimation(vote)
        circleProgressView.voteLabel.text = formattedString(vote ?? 0)
        fetchImage(poster)
    }
    
    private func formattedString(_ vote: Double) -> String {
        return String(format: "%.1f", vote)
    }
    
    private func fetchImage(_ poster: String?) {
        Task {
            do {
                let poster = try await Network.Client.shared.fetchImage(with: poster)
                DispatchQueue.main.async {
                    self.movieImageView.image = poster
                }
            } catch {
                DispatchQueue.main.async {
                    self.movieImageView.image = UIImage(systemName: "film")
                }
                print(error.localizedDescription)
            }
        }
    }
}
