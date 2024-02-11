//
//  FavouritesController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import UIKit
import Combine

class FavouritesController: UICollectionViewController {
    private var authService: AuthService?
    private var firestoreService: FirestoreService?
    private var subscriber: AnyCancellable?
    var alertManager: AlertManager?
    private var userID: String?
    let colorView = ColorView()
    var movies: [Movie] = []
    
    override init(collectionViewLayout: UICollectionViewLayout) {
        authService = AuthService()
        self.userID = authService?.currentUser?.id
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var sections = [Section]()
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favourites"
        collectionView.backgroundView = colorView
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        configureDataSource()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        getFavourites()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        colorView.gradientLayer.frame = colorView.bounds
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        DispatchQueue.main.async {
            self.collectionView.setCollectionViewLayout(self.createLayout(), animated: false)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movieDetailController: MovieDetailController!
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        movieDetailController = MovieDetailController(movie: item)
        
        navigationController?.pushViewController(movieDetailController, animated: true)
    }
    
    func getFavourites() {
        guard let userID = userID else { return }
        firestoreService = FirestoreService()
        subscriber = firestoreService?.getFafourites()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let strongSelf = self else { return }
                switch completion {
                case .finished:
                    strongSelf.movies = []
                case .failure(let error):
                    strongSelf.alertManager = AlertManager(strongSelf)
                    strongSelf.alertManager?.displayError(error.localizedDescription)
                }
            }, receiveValue: { [weak self] favourites in
                guard let strongSelf = self else { return }
                strongSelf.fetchFavourites(favourites)
            })
    }
    
}
