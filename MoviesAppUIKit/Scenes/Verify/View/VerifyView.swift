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
    let loginAction = PassthroughSubject<Void, Never>()
    let verifyAction = PassthroughSubject<Void, Never>()
    
    let verifyButton = ActionButton(
        title: "Resend after 60 seconds",
        color: .black.withAlphaComponent(0.3)
    )
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let lineView = LineView()
    
    private let informationTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black.withAlphaComponent(0.9)
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let centerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let sentInfo = "Verification letter has been sent by email:"
    private let verifyInfo = "Please verify your email address."
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        self.backgroundColor = .systemGray6
        
        self.addSubview(centerView)
        centerView.addSubview(stackView)
        stackView.addArrangedSubview(informationTitle)
        stackView.addArrangedSubview(lineView)
        centerView.addSubview(verifyButton)
        centerView.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        verifyButton.isEnabled = false
        verifyButton.addTarget(self, action: #selector(sendVerificationAction), for: .touchUpInside)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            centerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            centerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 40),
            centerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            centerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            centerView.heightAnchor.constraint(equalToConstant: 220),
            stackView.topAnchor.constraint(equalTo: centerView.topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: centerView.leftAnchor, constant: 15),
            stackView.rightAnchor.constraint(equalTo: centerView.rightAnchor),
            stackView.bottomAnchor.constraint(greaterThanOrEqualTo: verifyButton.topAnchor, constant: -15),
            verifyButton.leftAnchor.constraint(equalTo: centerView.leftAnchor, constant: 30),
            verifyButton.rightAnchor.constraint(equalTo: centerView.rightAnchor, constant: -30),
            verifyButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -15),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: centerView.bottomAnchor, constant: -15),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            lineView.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ])
    }
    
    func configureView(with email: String) {
        let text = sentInfo + "\n" + email + "\n" + verifyInfo
        informationTitle.text = text
    }
    
    @objc
    private func loginButtonAction() {
        loginAction.send(())
    }
    
    @objc
    private func sendVerificationAction() {
        verifyAction.send(())
    }
    
}
