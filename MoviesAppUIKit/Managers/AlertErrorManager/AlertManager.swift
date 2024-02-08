//
//  AlertManager.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 08.02.2024.
//

import Foundation
import UIKit

class AlertManager {
    let controller: UIViewController
    
    init(_ controller: UIViewController) {
        self.controller = controller
    }
    
    func displayError(_ error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.view.tintColor = .black
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        controller.present(alert, animated: true)
    }
}
