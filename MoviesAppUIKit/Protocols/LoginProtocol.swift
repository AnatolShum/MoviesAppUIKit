//
//  LoginProtocol.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import Foundation

protocol LoginProtocol: AnyObject {
    var email: String { get set }
    var password: String { get set }
    func logIn()
}
