//
//  ButtonsActions.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 05/10/2023.
//

import Foundation
import UIKit

extension FullScreenImageController {
    private func newPath(_ paths: [Photos]) {
        DispatchQueue.main.async {
            self.newPath = paths[self.photoIndex - 1].path
        }
    }
    
    @objc func previousPhoto() {
        if photoIndex > 1 {
            photoIndex -= 1
            newPath(paths)
        } else {
            photoIndex = paths.count
            newPath(paths)
        }
        changeCurrentImageTitle()
    }
    
    @objc func nextPhoto() {
        if photoIndex < paths.count {
            photoIndex += 1
            newPath(paths)
        } else {
            photoIndex = 1
            newPath(paths)
        }
        changeCurrentImageTitle()
    }
    
    func changeCurrentImageTitle() {
        DispatchQueue.main.async {
            self.currentImageButton.title = "\(self.photoIndex) of \(self.paths.count)"
        }
    }
}
