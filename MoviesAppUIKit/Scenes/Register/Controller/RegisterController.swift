//
//  RegisterController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 10/10/2023.
//

import UIKit
import FirebaseFirestore
import Combine

class RegisterController: UIViewController {
    private var titleView: TitleView?
    private var mainController: MainController?
    private var authService: AuthService?
    private var observer: AnyCancellable?
    private var alertManager: AlertManager?
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    
    var userName: String = ""
    var email: String = ""
    var password: String = ""
    
    override func loadView() {
        super.loadView()
        titleView = TitleView(title: "Register", color: .systemGreen, frame: view.frame)
        view = titleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
    }
    
    @objc func createAccount() {
        register()
    }
    
    @objc func nameTextFieldValueChanged() {
        userName = nameTextField.text ?? ""
    }
    
    @objc func emailTextFieldValueChanged() {
        email = emailTextField.text ?? ""
    }
    
    @objc func passwordTextFieldValueChanged() {
        password = passwordTextField.text ?? ""
    }
    
    private func register() {
        guard validate() else { return }
        
        authService = AuthService()
        observer = authService?.createUser(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let strongSelf = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    strongSelf.alertManager = AlertManager(strongSelf)
                    strongSelf.alertManager?.displayError(error.localizedDescription)
                }
            }, receiveValue: { [weak self] user in
                guard let strongSelf = self else { return }
                guard let id = user?.id else {
                    strongSelf.alertManager = AlertManager(strongSelf)
                    strongSelf.alertManager?.displayError("Authentication error")
                    return }
                strongSelf.saveUserRecord(id: id)
            })
    }
    
    private func saveUserRecord(id: String) {
        let newUser = User(id: id, name: userName, email: email, joined: Date().timeIntervalSince1970)
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
        
        presentMain()
    }
    
    private func validate() -> Bool {
        alertManager = AlertManager(self)
        guard !userName.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertManager?.displayError("Please fill in all fields.")
            return false }
        
        guard email.contains("@") && email.contains(".") else {
            alertManager?.displayError("Please enter valid email.")
            return false
        }
        
        guard password.count > 5 else {
            alertManager?.displayError("Minimum password length is 6 characters.")
            return false
        }
        
        return true
    }
    
    private func presentMain() {
        mainController = MainController()
        guard let mainController else { return }
        mainController.modalPresentationStyle = .fullScreen
        self.present(mainController, animated: true)
    }

}
