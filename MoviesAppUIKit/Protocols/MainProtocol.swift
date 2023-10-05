//
//  MainProtocol.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import Foundation

protocol MainProtocol: AnyObject {
    var currentUserId: String { get set }
    var isSignedIn: Bool { get }
}
