//
//  MainController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import UIKit
import FirebaseAuth

class MainController: UIViewController {
    private var handler: AuthStateDidChangeListenerHandle?
    var currentUserId: String = ""
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    private var tabBar: TabBarController!
    private var loginController: LoginController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser() {
        handler = Auth.auth().addStateDidChangeListener({ [weak self] _, user in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.currentUserId = user?.uid ?? ""
                self.checkScene()
            }
        })
    }

    private func checkScene() {
        if isSignedIn {
            tabBar = TabBarController(userID: currentUserId)
            tabBar.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(self.tabBar, animated: false)
            }
        } else {
            if ProcessInfo().arguments.contains("-ui-testing") {
                
            } else {
                loginController = LoginController()
                loginController.modalPresentationStyle = .fullScreen
                DispatchQueue.main.async {
                    self.present(self.loginController, animated: false)
                }
            }
        }
    }

}

extension MainController: MainProtocol {}
