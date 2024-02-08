//
//  RegisterController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 10/10/2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class RegisterController: UIViewController {
    private var titleView: TitleView!
    private var tabBar: TabBarController!
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
        let service = AuthService()
//        service.createUser(email: email, password: password) { result in
//            switch result {
//            case .success(let user):
//                print(user)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
        
        
        
        
//        guard validate() else { return }
//        
//        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
//            guard let self = self else { return }
//            guard let userID = result?.user.uid else { return }
//            
//            self.saveUserRecord(id: userID)
//        }
    }
    
    private func saveUserRecord(id: String) {
        let newUser = User(id: id, name: userName, email: email, joined: Date().timeIntervalSince1970)
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
        
        presentTabBar(userID: id)
    }
    
    private func validate() -> Bool {
        guard !userName.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            displayError("Please fill in all fields.")
            return false }
        
        guard email.contains("@") && email.contains(".") else {
            displayError("Please enter valid email.")
            return false
        }
        
        guard password.count > 6 else {
            displayError("Minimum password length is 6 characters.")
            return false
        }
        
        return true
    }
    
    private func presentTabBar(userID: String) {
        tabBar = TabBarController(userID: userID)
        tabBar.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(self.tabBar, animated: false)
        }
    }

}
