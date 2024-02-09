//
//  RegisterCreateUI.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 10/10/2023.
//

import Foundation
import UIKit

extension RegisterController {
    func createUI() {
        let registerView = UIView()
        registerView.backgroundColor = .white.withAlphaComponent(0.7)
        registerView.layer.cornerRadius = 10
        registerView.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextField = UITextField()
        nameTextField.addTarget(self, action: #selector(nameTextFieldValueChanged), for: .allEvents)
        nameTextField.placeholder = "User name"
        nameTextField.autocapitalizationType = .words
        nameTextField.autocorrectionType = .no
        nameTextField.backgroundColor = .clear
        
        emailTextField = UITextField()
        emailTextField.addTarget(self, action: #selector(emailTextFieldValueChanged), for: .allEvents)
        emailTextField.placeholder = "Email address"
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.backgroundColor = .clear
        
        passwordTextField = UITextField()
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldValueChanged), for: .allEvents)
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .clear
        
        let registerButton = ActionButton(title: "Register", color: .systemBlue)
        registerButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        
        let lineViews = makeLineViews([nameTextField, emailTextField, passwordTextField])
        let stackView = UIStackView(arrangedSubviews:
            [nameTextField, lineViews[0], emailTextField, lineViews[1], passwordTextField, lineViews[2]])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(registerView)
        registerView.addSubview(stackView)
        registerView.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            registerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            registerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            registerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            registerView.heightAnchor.constraint(equalToConstant: 200),
            stackView.topAnchor.constraint(equalTo: registerView.topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: registerView.leftAnchor, constant: 15),
            stackView.rightAnchor.constraint(equalTo: registerView.rightAnchor),
            registerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            registerButton.leftAnchor.constraint(equalTo: registerView.leftAnchor, constant: 30),
            registerButton.rightAnchor.constraint(equalTo: registerView.rightAnchor, constant: -30),
            registerButton.bottomAnchor.constraint(equalTo: registerView.bottomAnchor, constant: -15)
        ])
        
        lineViews.forEach { lineView in
            lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
            lineView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
            lineView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        }
    }
    
    typealias LineViews = [UIView]
    private func makeLineViews(_ views: [UIView]) -> LineViews {
        var lineViews: [UIView] = []
        for _ in 1...views.count {
            let line = LineView()
            lineViews.append(line)
        }
        
        return lineViews
    }
}
