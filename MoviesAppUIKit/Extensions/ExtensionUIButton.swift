//
//  ExtensionUIButton.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 11.02.2024.
//

import Foundation
import ObjectiveC
import UIKit

extension UIButton {
    private struct AssociatedKeys {
        static var textKey = "textKey"
    }
    
    var text: String? {
        get {
            return objc_getAssociatedObject(self, AssociatedKeys.textKey) as? String
        }
        set {
            objc_setAssociatedObject(self, AssociatedKeys.textKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.setTitle(newValue, for: .normal)
        }
    }
}
