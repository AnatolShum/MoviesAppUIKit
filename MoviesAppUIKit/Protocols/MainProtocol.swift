//
//  MainProtocol.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import Foundation

protocol MainProtocol: AnyObject {
    var authService: AuthService { get set }
    var isEmailVerified: Bool { get }
    var isSignedIn: Bool { get }
}
