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
    private var counter = 60
    private var timer = Timer()
    
    override func loadView() {
        super.loadView()
        
        authService = AuthService()
        let email = authService?.currentUser?.email
        verifyView = VerifyView(frame: view.bounds)
        verifyView?.configureView(with: email ?? "unknown email")
        view = verifyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveLoginAction()
        receiveVerifyAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sendEmailVerification()
    }
    
    private func receiveLoginAction() {
        verifyView?.loginAction
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.signOut()
            }).store(in: &observers)
    }
    
    private func receiveVerifyAction() {
        verifyView?.verifyAction
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.sendEmailVerification()
            }).store(in: &observers)
    }
    
    private func signOut() {
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
    
    private func sendEmailVerification() {
        authService?.sendEmailVerification()
            .sink(receiveCompletion: { [weak self] completion in
                guard let strongSelf = self else { return }
                switch completion {
                case .finished:
                    strongSelf.runTimer()
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
    
    private func runTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateButton),
            userInfo: nil,
            repeats: true)
    }
    
    @objc
    private func updateButton() {
        let button = verifyView?.verifyButton
        if (counter > 0) {
            counter -= 1
            DispatchQueue.main.async {
                button?.isEnabled = false
                button?.backgroundColor = .black.withAlphaComponent(0.3)
                button?.setTitle("Resend after \(self.counter) seconds", for: .normal)
            }
        } else {
            DispatchQueue.main.async {
                button?.isEnabled = true
                button?.backgroundColor = .systemIndigo
                button?.setTitle("Send email verification", for: .normal)
                self.timer.invalidate()
                self.counter = 60
            }
        }
    }
    
}
