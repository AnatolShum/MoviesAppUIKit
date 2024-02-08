//
//  MainControllerMock.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 10/10/2023.
//

import UIKit
import Combine

class MainControllerMock: UIViewController {
    private var tabBar: TabBarController?
    private var loginNavigationController: UINavigationController?
    private var loginController: LoginController?
    private var observer: AnyCancellable?
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
        
        observer = authService.signOut()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Signed out")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { _ in
                self.checkScene()
            }
    }
    
    private func checkScene() {
        if isSignedIn {
            presentTabBar()
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

extension MainControllerMock: MainProtocol {}
