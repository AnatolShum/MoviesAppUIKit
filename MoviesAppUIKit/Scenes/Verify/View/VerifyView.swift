//
//  VerifyView.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 08.02.2024.
//

import Foundation
import UIKit
import Combine

class VerifyView: UIView {
    let action = PassthroughSubject<Void, Never>()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemMint
        self.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            loginButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func loginButtonAction() {
        action.send(())
    }
    
}
