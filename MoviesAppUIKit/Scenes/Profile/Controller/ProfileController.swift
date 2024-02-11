//
//  ProfileController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import UIKit
import Combine

class ProfileController: UIViewController {
    let colorView = ColorView()
    var loadingView: LoadingView!
    var mainController: MainController!
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
    
    private var subscribers: [AnyCancellable] = []
    private var firestoreService: FirestoreService?
    private var authService: AuthService?
    private var alertManager: AlertManager?
    
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
        firestoreService = FirestoreService()
        firestoreService?.getUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let strongSelf = self else { return }
                switch completion {
                case .finished:
                    strongSelf.stopShowingLoadingView()
                case .failure(let error):
                    strongSelf.alertManager = AlertManager(strongSelf)
                    strongSelf.alertManager?.displayError(error.localizedDescription)
                }
            }, receiveValue: { [weak self] user in
                guard let strongSelf = self else { return }
                strongSelf.setLabelData(user)
            })
            .store(in: &subscribers)
    }
    
    private func setLabelData(_ user: User) {
        userNameLabel.text = user.name
        emailLabel.text = user.email
        memberSinceLabel.text = "\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))"
    }
    
    @objc func signOutButtonTapped() {
        authService = AuthService()
        authService?.signOut()
            .sink(receiveCompletion: { [weak self] completion in
                guard let strongSelf = self else { return }
                switch completion {
                case .finished:
                    strongSelf.presentMainController()
                    strongSelf.deleteItems()
                case .failure(let error):
                    strongSelf.alertManager = AlertManager(strongSelf)
                    strongSelf.alertManager?.displayError(error.localizedDescription)
                }
            }, receiveValue: {})
            .store(in: &subscribers)
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
