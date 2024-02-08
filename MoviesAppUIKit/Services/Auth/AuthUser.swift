//
//  AuthUser.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 07.02.2024.
//

import Foundation

class AuthUser {
    let id: String
    let isEmailVerified: Bool
    
    init(id: String, isEmailVerified: Bool) {
        self.id = id
        self.isEmailVerified = isEmailVerified
    }
}
