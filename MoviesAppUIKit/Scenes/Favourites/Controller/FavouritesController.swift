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
    let colorView = ColorView()
    var movies: [Movie] = []
    
    private let userID: String
    
    init(userID: String, collectionViewLayout: UICollectionViewLayout) {
        self.userID = userID
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var sections = [Section]()
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, Movie> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        return snapshot
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFavourites()
        
        title = "Favourites"
        collectionView.backgroundView = colorView
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        configureDataSource()
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
    
    private func getFavourites() {
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
