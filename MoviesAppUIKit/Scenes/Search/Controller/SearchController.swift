//
//  SearchController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import UIKit

class SearchController: UICollectionViewController {
    let colorView = ColorView()
    let searchController = UISearchController()
    
    var movies: [Movie] = []
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
        
        title = "Search"
        
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        
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

    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movieDetailController: MovieDetailController!
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        movieDetailController = MovieDetailController(movie: item)
        
        navigationController?.pushViewController(movieDetailController, animated: true)
    }

}
