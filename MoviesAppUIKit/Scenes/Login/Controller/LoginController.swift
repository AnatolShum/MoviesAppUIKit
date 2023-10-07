//
//  LoginController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
    private var titleView: TitleView!
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
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard error == nil else {
                self?.displayError(error!.localizedDescription)
                return }
            
            self?.presentTabBar()
        }
    }
    
    private func validate() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            displayError("Please fill in all fields.")
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            displayError("Please enter valid email.")
            return false
        }
        
        return true
    }
    
    private func presentTabBar() {
        let mainController = MainController()
        mainController.modalPresentationStyle = .fullScreen
        self.present(mainController, animated: true)
    }
    
    @objc func forgotButtonTapped() {
        
    }
    
    @objc func createAccountTapped() {
        
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
