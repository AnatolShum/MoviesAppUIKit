//
//  ProfileController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileController: UIViewController {
    let colorView = ColorView()
    var loadingView: LoadingView!
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.tintColor = .black.withAlphaComponent(0.3)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var userNameLabel: UILabel!
    var emailLabel: UILabel!
    var memberSinceLabel: UILabel!
    
    var mainController: MainController!
    
    override func loadView() {
        super.loadView()
       
        view = colorView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        createProfileUI()
        fetchUser()
        startShowingLoadingView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        colorView.gradientLayer.frame = view.bounds
    }
    
    private func fetchUser() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .getDocument { [weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil else { return }
                
                DispatchQueue.main.async {
                    let user = User(id: data["id"] as? String ?? "",
                                    name: data["name"] as? String ?? "",
                                    email: data["email"] as? String ?? "",
                                    joined: data["joined"] as? TimeInterval ?? 0)
                    self?.setLabelData(user)
                    self?.stopShowingLoadingView()
                }
            }
    }
    
    private func setLabelData(_ user: User) {
        userNameLabel.text = user.name
        emailLabel.text = user.email
        memberSinceLabel.text = "\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))"
    }
    
    @objc func signOutButtonTapped() {
        do {
            try Auth.auth().signOut()
            presentMainController()
            deleteItems()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func presentMainController() {
        mainController = MainController()
        mainController.modalPresentationStyle = .fullScreen
        self.present(mainController, animated: true)
    }
    
    private func deleteItems() {
        Item.nowPlayingMovies = []
        Item.topRatedMovies = []
        Item.popularMovies = []
    }
    
}
