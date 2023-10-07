//
//  CreateProfileUI.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 03/10/2023.
//

import Foundation
import UIKit

extension ProfileController {
    func createProfileUI() {
        view.addSubview(profileImage)
        
        let nameVStack = VStack()
        let nameHStack = HStack()
        nameHStack.isLayoutMarginsRelativeArrangement = true
        nameHStack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        let userNameView = CellView()
        let nameHeaderLabel = HeaderLabel()
        nameHeaderLabel.text = "NAME"
        userNameLabel = ProfileLabel()
        userNameView.addSubview(userNameLabel)
        view.addSubview(nameVStack)
        nameHStack.addArrangedSubview(nameHeaderLabel)
        nameVStack.addArrangedSubview(nameHStack)
        nameVStack.addArrangedSubview(userNameView)
        
        let emailVStack = VStack()
        let emailHStack = HStack()
        emailHStack.isLayoutMarginsRelativeArrangement = true
        emailHStack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        let emailView = CellView()
        let emailHeaderLabel = HeaderLabel()
        emailHeaderLabel.text = "EMAIL"
        emailLabel = ProfileLabel()
        emailView.addSubview(emailLabel)
        view.addSubview(emailVStack)
        emailHStack.addArrangedSubview(emailHeaderLabel)
        emailVStack.addArrangedSubview(emailHStack)
        emailVStack.addArrangedSubview(emailView)
        
        let memberSinceVStack = VStack()
        let memberSinceHStack = HStack()
        memberSinceHStack.isLayoutMarginsRelativeArrangement = true
        memberSinceHStack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        let memberSinceView = CellView()
        let memberSinceHeaderLabel = HeaderLabel()
        memberSinceHeaderLabel.text = "MEMBER SINCE"
        memberSinceLabel = ProfileLabel()
        memberSinceView.addSubview(memberSinceLabel)
        view.addSubview(memberSinceVStack)
        memberSinceHStack.addArrangedSubview(memberSinceHeaderLabel)
        memberSinceVStack.addArrangedSubview(memberSinceHStack)
        memberSinceVStack.addArrangedSubview(memberSinceView)
        
        let signOutView = CellView()
        let signOutButton: UIButton = {
            let button = UIButton()
            button.setTitle("Sign out", for: .normal)
            button.setTitleColor(.systemRed, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 18)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        signOutView.addSubview(signOutButton)
        view.addSubview(signOutView)
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            userNameLabel.topAnchor.constraint(equalTo: userNameView.topAnchor, constant: 10),
            userNameLabel.leftAnchor.constraint(equalTo: userNameView.leftAnchor, constant: 20),
            userNameLabel.rightAnchor.constraint(equalTo: userNameView.rightAnchor, constant: -20),
            userNameLabel.bottomAnchor.constraint(equalTo: userNameView.bottomAnchor, constant: -10),
            nameVStack.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            nameVStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            nameVStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            emailLabel.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 10),
            emailLabel.leftAnchor.constraint(equalTo: emailView.leftAnchor, constant: 20),
            emailLabel.rightAnchor.constraint(equalTo: emailView.rightAnchor, constant: -20),
            emailLabel.bottomAnchor.constraint(equalTo: emailView.bottomAnchor, constant: -10),
            emailVStack.topAnchor.constraint(equalTo: nameVStack.bottomAnchor, constant: 30),
            emailVStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            emailVStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            memberSinceLabel.topAnchor.constraint(equalTo: memberSinceView.topAnchor, constant: 10),
            memberSinceLabel.leftAnchor.constraint(equalTo: memberSinceView.leftAnchor, constant: 20),
            memberSinceLabel.rightAnchor.constraint(equalTo: memberSinceView.rightAnchor, constant: -20),
            memberSinceLabel.bottomAnchor.constraint(equalTo: memberSinceView.bottomAnchor, constant: -10),
            memberSinceVStack.topAnchor.constraint(equalTo: emailVStack.bottomAnchor, constant: 30),
            memberSinceVStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            memberSinceVStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            signOutButton.centerXAnchor.constraint(equalTo: signOutView.centerXAnchor),
            signOutButton.centerYAnchor.constraint(equalTo: signOutView.centerYAnchor),
            signOutView.topAnchor.constraint(greaterThanOrEqualTo: memberSinceVStack.bottomAnchor, constant: 70),
            signOutView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            signOutView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
}
