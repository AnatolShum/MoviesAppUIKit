//
//  PresentLoadingView.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 06/10/2023.
//

import Foundation
import UIKit

extension ProfileController {
    func startShowingLoadingView() {
        loadingView = LoadingView()
        addChild(loadingView)
        loadingView.view.frame = view.frame
        view.addSubview(loadingView.view)
        loadingView.didMove(toParent: self)
    }
    
    func stopShowingLoadingView() {
        loadingView.willMove(toParent: nil)
        loadingView.view.removeFromSuperview()
        loadingView.removeFromParent()
        loadingView = nil
    }
}
