//
//  ForgotController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 10/10/2023.
//

import UIKit
import FirebaseAuth

class ForgotController: UIViewController {
    private var titleView: TitleView!
    var emailTextField: UITextField!
    var email: String = ""
    var isNotError: Bool = false {
        didSet {
            if isNotError {
                dismiss(animated: true)
            }
        }
    }
    
    override func loadView() {
        super.loadView()
     
        titleView = TitleView(title: "Lost password", color: .systemOrange, frame: view.frame)
        view = titleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
    }
    
    @objc func resetPassword() {
        sendPasswordReset()
    }
    
    @objc func emailTextFieldValueChanged() {
        email = emailTextField.text ?? ""
    }
    
    private func sendPasswordReset() {
        guard validate() else { return }
        
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error?.localizedDescription {
                self.displayError(error)
            } else {
                self.isNotError = true
            }
        }
    }
    
    private func validate() -> Bool {
        isNotError = false
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            displayError("Please fill in email address.")
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            displayError("Please enter valid email.")
            return false
        }
        
        return true
    }
    
}
