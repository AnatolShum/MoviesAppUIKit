//
//  LoginController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import UIKit
import Combine

class LoginController: UIViewController {
    private var titleView: TitleView!
    private var mainController: MainController!
    private var forgotController: ForgotController!
    private var registerController: RegisterController!
    private var alertManager: AlertManager?
    private var authService: AuthService?
    private var observer: AnyCancellable?
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var forgotButton: UIButton!
    
    var email: String = ""
    var password: String = ""
    
    override func loadView() {
        super.loadView()
        titleView = TitleView(title: "Movies", color: .systemBlue, frame: view.frame)
        view = titleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
    }
    
    func logIn() {
        guard validate() else { return }
        authService = AuthService()
        observer = authService?.signIn(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let strongSelf = self else { return }
                switch completion {
                case .finished:
                    strongSelf.presentMain()
                case .failure(let error):
                    strongSelf.alertManager = AlertManager(strongSelf)
                    strongSelf.alertManager?.displayError(error.localizedDescription)
                }
            }, receiveValue: {_ in })
    }
    
    private func validate() -> Bool {
        alertManager = AlertManager(self)
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertManager?.displayError("Please fill in all fields.")
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            alertManager?.displayError("Please enter valid email.")
            return false
        }
        
        return true
    }
    
    private func presentMain() {
        mainController = MainController()
        mainController.modalPresentationStyle = .fullScreen
        self.present(mainController, animated: true)
    }
    
    @objc func forgotButtonTapped() {
        forgotController = ForgotController()
        navigationController?.pushViewController(forgotController, animated: true)
    }
    
    @objc func createAccountTapped() {
        registerController = RegisterController()
        navigationController?.pushViewController(registerController, animated: true)
    }
    
    @objc func logInButtonTapped() {
        logIn()
    }
    
    @objc func emailTextFieldValueChanged() {
        email = emailTextField.text ?? ""
    }
    
    @objc func passwordTextFieldValueChanged() {
        password = passwordTextField.text ?? ""
    }
    
}

extension LoginController: LoginProtocol {}
