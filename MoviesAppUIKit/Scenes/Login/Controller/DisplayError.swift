//
//  DisplayError.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 03/10/2023.
//

import Foundation
import UIKit

extension LoginController {
    func displayError(_ error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.view.tintColor = .black
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
