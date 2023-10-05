//
//  ProfileLabel.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 03/10/2023.
//

import Foundation
import UIKit

class ProfileLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textAlignment = .left
        self.textColor = .black.withAlphaComponent(0.8)
        self.font = .boldSystemFont(ofSize: 18)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
