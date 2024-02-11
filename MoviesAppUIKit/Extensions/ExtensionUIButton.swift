//
//  ExtensionUIButton.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 11.02.2024.
//

import Foundation
import UIKit

extension UIButton {
    public var text: String? {
        get {
            return self.titleLabel?.text
        }
        set {
            self.setTitle(newValue, for: .normal)
            self.setTitle(newValue, for: .selected)
            self.setTitle(newValue, for: .disabled)
            self.setTitle(newValue, for: .highlighted)
        }
    }
}
