//
//  MainController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import UIKit

class MainController: UIViewController {
    private var tabBar: TabBarController?
    private var loginNavigationController: UINavigationController?
    private var loginController: LoginController?
    private var verifyController: VerifyController?
    internal var authService: AuthService = AuthService()
    internal var isSignedIn: Bool {
        return authService.currentUser != nil
    }
    internal var isEmailVerified: Bool {
        if let user = authService.currentUser {
            return user.isEmailVerified
        } else {
            return false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        checkScene()
    }

    private func checkScene() {
        if isSignedIn {
            if isEmailVerified {
                presentTabBar()
            } else {
                presentVerifyView()
            }
        } else {
            presentLoginView()
        }
    }
    
    private func presentTabBar() {
        tabBar = TabBarController()
        guard let tabBar else { return }
        tabBar.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(tabBar, animated: false)
        }
    }
    
    private func presentVerifyView() {
        verifyController = VerifyController()
        guard let verifyController else { return }
        verifyController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(verifyController, animated: false)
        }
    }
    
    private func presentLoginView() {
        loginController = LoginController()
        guard let loginController else { return }
        loginNavigationController = UINavigationController(rootViewController: loginController)
        guard let loginNavigationController else { return }
        loginNavigationController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(loginNavigationController, animated: false)
        }
    }

}

extension MainController: MainProtocol {}
