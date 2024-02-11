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
    private var subscribers: [AnyCancellable] = []
    private var counter = 60
    private var timer = Timer()
    @Published private var isButtonEnable: Bool = false
    @Published private var buttonBackgroundColor: UIColor? = ButtonColors.disable
    @Published private var buttonTitle: String? = "Resend after 60 seconds"
    private enum ButtonColors {
        static let disable = UIColor.black.withAlphaComponent(0.3)
        static let enable = UIColor.systemIndigo
    }
    
    override func loadView() {
        super.loadView()
        
        authService = AuthService()
        let email = authService?.currentUser?.email
        verifyView = VerifyView(frame: view.bounds)
        verifyView?.configureView(with: email)
        view = verifyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveLoginAction()
        receiveVerifyAction()
        subscribe()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sendEmailVerification()
    }
    
    private func subscribe() {
        let button = verifyView?.verifyButton
        guard let button else { return }
        
        $isButtonEnable
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: button)
            .store(in: &subscribers)
        
        $buttonBackgroundColor
            .receive(on: DispatchQueue.main)
            .assign(to: \.backgroundColor, on: button)
            .store(in: &subscribers)
        
        $buttonTitle
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: button)
            .store(in: &subscribers)
    }
    
    private func receiveLoginAction() {
        verifyView?.loginAction
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.signOut()
            }).store(in: &subscribers)
    }
    
    private func receiveVerifyAction() {
        verifyView?.verifyAction
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.sendEmailVerification()
            }).store(in: &subscribers)
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
            .store(in: &subscribers)
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
            .store(in: &subscribers)
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
        if counter > 0 {
            counter -= 1
            isButtonEnable = false
            buttonBackgroundColor = ButtonColors.disable
            buttonTitle = "Resend after \(self.counter) seconds"
        } else {
            isButtonEnable = true
            buttonBackgroundColor = ButtonColors.enable
            buttonTitle = "Send email verification"
            timer.invalidate()
            counter = 60
        }
    }
    
}
