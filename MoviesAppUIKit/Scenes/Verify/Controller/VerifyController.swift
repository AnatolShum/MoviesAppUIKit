//
//  VerifyController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 08.02.2024.
//

import Foundation
import UIKit
import Combine

class VerifyController: UIViewController {
    private var verifyView: VerifyView?
    private var loginController: LoginController?
    private var loginNavigationController: UINavigationController?
    private var authService: AuthService?
    private var alertManager: AlertManager?
    private var observers: [AnyCancellable] = []
    
    override func loadView() {
        super.loadView()
        
        verifyView = VerifyView(frame: view.bounds)
        view = verifyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveButtonAction()
    }
    
    private func receiveButtonAction() {
        verifyView?.action
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.signOut()
            }).store(in: &observers)
    }
    
    private func signOut() {
        authService = AuthService()
        authService?.signOut()
            .sink(receiveCompletion: { [weak self] completion in
                guard let strongSelf = self else { return }
                switch completion {
                case .finished:
                    strongSelf.presentLoginView()
                case .failure(let error):
                    strongSelf.alertManager = AlertManager(strongSelf)
                    strongSelf.alertManager?.displayError(error.localizedDescription)
                }
            }, receiveValue: {})
            .store(in: &observers)
    }
    
    private func presentLoginView() {
        loginController = LoginController()
        guard let loginController else { return }
        loginNavigationController = UINavigationController(rootViewController: loginController)
        guard let loginNavigationController else { return }
        loginNavigationController.modalPresentationStyle = .fullScreen
        present(loginNavigationController, animated: false)
    }
    
}
