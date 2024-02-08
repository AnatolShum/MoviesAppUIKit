//
//  FirebaseProvider.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 07.02.2024.
//

import Foundation
import FirebaseCore

internal class FirebaseProvider: FirebaseProviderProtocol {
    func configure() {
        FirebaseApp.configure()
    }
}
