//
//  SetupUI.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 05/10/2023.
//

import Foundation
import UIKit

extension MovieDetailView {
    func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(topImageView)
       
        let titleStackView = checkTitleLength()
        titleStackView.spacing = 5
        titleStackView.alignment = .center
        scrollView.addSubview(titleStackView)

        circularProgressView.progressAnimation(movie.vote)
        circularProgressView.voteLabel.text = formattedString(movie.vote ?? 0)
        hStack = HStack(arrangedSubviews: [circularProgressView, scoreLabel, spacerLabel, trailerButton])
        hStack.spacing = 20
        hStack.alignment = .center
        hStack.distribution = .equalCentering
        scrollView.addSubview(hStack)
        vStack = VStack(arrangedSubviews: [overviewLabel, descriptionLabel, photosLabel])
        vStack.spacing = 15
        scrollView.addSubview(vStack)
        
        scrollView.addSubview(photosCollectionView)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            topImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            topImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            topImageView.heightAnchor.constraint(equalTo: topImageView.widthAnchor, multiplier: 1/1.3),
            topImageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            topImageView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            titleStackView.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 10),
            titleStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleStackView.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor),
            titleStackView.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor),
            hStack.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 20),
            hStack.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 50),
            hStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 30),
            vStack.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 15),
            vStack.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -15),
            
            photosCollectionView.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 10),
            photosCollectionView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 15),
            photosCollectionView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -15),
            photosCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            photosCollectionView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
