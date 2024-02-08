//
//  FavouritesController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class FavouritesController: UICollectionViewController {
    private var authService: AuthService?
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
        var favourites: [Favourite] = []
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .collection("favourites")
            .getDocuments { [weak self] snapshot, error in
                guard let self = self else { return }
                guard let documents = snapshot?.documents else { return}
                documents.forEach { document in
                    let data = document.data()
                    let favourite = Favourite(
                        id: data["id"] as? String ?? "",
                        movieID: data["movieID"] as? Int ?? 0)
                    favourites.append(favourite)
                }
                
                self.fetchFavourites(favourites)
            }
    }
    
}
