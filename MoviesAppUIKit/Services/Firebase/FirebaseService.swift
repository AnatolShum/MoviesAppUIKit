//
//  FirebaseService.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 07.02.2024.
//

import Foundation

class FirebaseService: FirebaseProviderProtocol {
    private let provider: FirebaseProviderProtocol
    
    init() {
        self.provider = FirebaseProvider()
    }
    
    func configure() {
        provider.configure()
    }
}
