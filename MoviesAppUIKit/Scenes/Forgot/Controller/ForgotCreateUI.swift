//
//  ForgotCreateUI.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 10/10/2023.
//

import Foundation
import UIKit

extension ForgotController {
    func createUI() {
        let forgotView = UIView()
        forgotView.backgroundColor = .white.withAlphaComponent(0.7)
        forgotView.layer.cornerRadius = 10
        forgotView.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField = UITextField()
        emailTextField.addTarget(self, action: #selector(emailTextFieldValueChanged), for: .allEvents)
        emailTextField.placeholder = "Email address"
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.backgroundColor = .clear
        
        let forgotButton = ActionButton(title: "Send password reset", color: .systemPink.withAlphaComponent(0.9))
        forgotButton.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        
        let lineView = LineView()
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, lineView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(forgotView)
        forgotView.addSubview(stackView)
        forgotView.addSubview(forgotButton)
        
        NSLayoutConstraint.activate([
            forgotView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            forgotView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            forgotView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            forgotView.heightAnchor.constraint(equalToConstant: 110),
            stackView.topAnchor.constraint(equalTo: forgotView.topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: forgotView.leftAnchor, constant: 15),
            stackView.rightAnchor.constraint(equalTo: forgotView.rightAnchor),
            forgotButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            forgotButton.leftAnchor.constraint(equalTo: forgotView.leftAnchor, constant: 30),
            forgotButton.rightAnchor.constraint(equalTo: forgotView.rightAnchor, constant: -30),
            forgotButton.bottomAnchor.constraint(equalTo: forgotView.bottomAnchor, constant: -15),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            lineView.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ])
    }
}
