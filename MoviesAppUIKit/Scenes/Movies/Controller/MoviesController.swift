//
//  MoviesController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import UIKit

class MoviesController: UICollectionViewController {
    let colorView = ColorView()
    
    var sections = [Section]()
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
   
    var nowPlayingPage: Int = 1
    var topRatedPage: Int = 1
    var popularPage: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
      
        fetchNowPlaying(with: nowPlayingPage)
        fetchTopRated(with: topRatedPage)
        fetchPopular(with: popularPage)
        
        collectionView.backgroundView = colorView
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: SupplementaryViewKind.header, withReuseIdentifier: HeaderView.reuseIdentifier)
        configureDataSource()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        DispatchQueue.main.async {
            self.snapshot.reloadItems(Item.nowPlayingMovies)
            self.snapshot.reloadItems(Item.topRatedMovies)
            self.snapshot.reloadItems(Item.popularMovies)
            self.dataSource.apply(self.snapshot, animatingDifferences: false)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        colorView.gradientLayer.frame = colorView.bounds
    }
   
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movieDetailController: MovieDetailController!
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        switch indexPath.section {
        case 0:
            movieDetailController = MovieDetailController(movie: item.nowPlaying!)
        case 1:
            movieDetailController = MovieDetailController(movie: item.topRated!)
        case 2:
            movieDetailController = MovieDetailController(movie: item.popular!)
        default:
            break
        }
        navigationController?.pushViewController(movieDetailController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if Item.nowPlayingMovies.count - 5 == indexPath.item {
                nowPlayingPage += 1
                fetchNowPlaying(with: nowPlayingPage)
            }
        case 1:
            if Item.topRatedMovies.count - 5 == indexPath.item {
                topRatedPage += 1
                fetchTopRated(with: topRatedPage)
            }
        case 2:
            if Item.popularMovies.count - 5 == indexPath.item {
                popularPage += 1
                fetchPopular(with: popularPage)
            }
        default:
            break
        }
    }

}
