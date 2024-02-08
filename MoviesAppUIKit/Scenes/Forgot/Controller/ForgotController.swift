//
//  ForgotController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 10/10/2023.
//

import UIKit
import Combine

class ForgotController: UIViewController {
    private var titleView: TitleView!
    private var authService: AuthService?
    private var alertManager: AlertManager?
    private var observer: AnyCancellable?
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
        authService = AuthService()
        observer = authService?.sendPasswordReset(email: email)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let strongSelf = self else { return }
                switch completion {
                case .finished:
                    strongSelf.isNotError = true
                case .failure(let error):
                    strongSelf.alertManager = AlertManager(strongSelf)
                    strongSelf.alertManager?.displayError(error.localizedDescription)
                }
            }, receiveValue: {})
    }
    
    private func validate() -> Bool {
        alertManager = AlertManager(self)
        isNotError = false
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertManager?.displayError("Please fill in email address.")
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            alertManager?.displayError("Please enter valid email.")
            return false
        }
        
        return true
    }
    
}
