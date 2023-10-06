//
//  CreateUI.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import Foundation
import UIKit

extension LoginController {
    func createUI() {
        let loginView = UIView()
        loginView.backgroundColor = .white.withAlphaComponent(0.7)
        loginView.layer.cornerRadius = 10
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        forgotButton = UIButton()
        forgotButton.setTitle("Forgot password?", for: .normal)
        forgotButton.setTitleColor(.black.withAlphaComponent(0.6), for: .normal)
        forgotButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        forgotButton.addTarget(self, action: #selector(forgotButtonTapped), for: .touchUpInside)
        
        let loginButton = ActionButton(title: "Log in", color: .systemRed.withAlphaComponent(0.9))
        loginButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        
        let createAccountButton = UIButton()
        createAccountButton.setTitle("Create an account", for: .normal)
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        
        let lineViews = makeLineViews([emailTextField, passwordTextField, forgotButton])
        let stackView = UIStackView(arrangedSubviews: [emailTextField, lineViews[0], passwordTextField, lineViews[1], forgotButton, lineViews[2]])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loginView)
        loginView.addSubview(stackView)
        loginView.addSubview(loginButton)
        view.addSubview(createAccountButton)
        
        NSLayoutConstraint.activate([
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            loginView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            loginView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            loginView.heightAnchor.constraint(equalToConstant: 200),
            stackView.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: loginView.leftAnchor, constant: 15),
            stackView.rightAnchor.constraint(equalTo: loginView.rightAnchor),
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            loginButton.leftAnchor.constraint(equalTo: loginView.leftAnchor, constant: 30),
            loginButton.rightAnchor.constraint(equalTo: loginView.rightAnchor, constant: -30),
            loginButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -15),
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
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
