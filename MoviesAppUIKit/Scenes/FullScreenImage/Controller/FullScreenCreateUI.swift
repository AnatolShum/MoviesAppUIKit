//
//  FullScreenCreateUI.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 05/10/2023.
//

import Foundation
import UIKit

extension FullScreenImageController {
    func setupUI() {
        getImageIndex(path: path, paths: paths)
        currentImageButton = UIBarButtonItem(title: "\(photoIndex) of \(paths.count)", style: .plain, target: self, action: nil)
        view.addSubview(centralImage)
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            centralImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centralImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centralImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            centralImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            centralImage.heightAnchor.constraint(equalTo: centralImage.widthAnchor, multiplier: 1/1.5),
            previousButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60),
            previousButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            previousButton.rightAnchor.constraint(lessThanOrEqualTo: nextButton.leftAnchor),
            previousButton.heightAnchor.constraint(equalToConstant: 40),
            previousButton.widthAnchor.constraint(equalToConstant: 25),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        previousButton.addTarget(self, action: #selector(previousPhoto), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextPhoto), for: .touchUpInside)
    }
    
    private func getImageIndex(path: String?, paths: [Photos]) {
        guard let path = path else { return }
        for (index, element) in paths.enumerated() {
            if element.path == path {
                DispatchQueue.main.async {
                    self.photoIndex = index + 1
                    self.changeCurrentImageTitle()
                }
            }
        }
    }
}
