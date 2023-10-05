//
//  TabBarController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let moviesController = MoviesController(collectionViewLayout: UICollectionViewFlowLayout())
    private let favouritesController = FavouritesController(collectionViewLayout: UICollectionViewFlowLayout())
    private let searchController = SearchController(collectionViewLayout: UICollectionViewFlowLayout())
    private let profileController = ProfileController()
    
    private var moviesNavigationController: UINavigationController!
    private var favouritesNavigationController: UINavigationController!
    private var searchNavigationController: UINavigationController!
    private var profileNavigationController: UINavigationController!
    
    private var navigationControllers: [UINavigationController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        configureTabBar()
        configureNavigationBars()
    }
    
    private func configureTabBar() {
        moviesNavigationController = UINavigationController(rootViewController: moviesController)
        favouritesNavigationController = UINavigationController(rootViewController: favouritesController)
        searchNavigationController = UINavigationController(rootViewController: searchController)
        profileNavigationController = UINavigationController(rootViewController: profileController)
        
        navigationControllers = [
            moviesNavigationController,
            favouritesNavigationController,
            searchNavigationController,
            profileNavigationController
        ]
        
        self.viewControllers = navigationControllers
        
        let movieTabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film"), tag: 0)
        let favouritesTabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "star"), tag: 1)
        let searchTabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        
        moviesNavigationController.tabBarItem = movieTabBarItem
        favouritesNavigationController.tabBarItem = favouritesTabBarItem
        searchNavigationController.tabBarItem = searchTabBarItem
        profileNavigationController.tabBarItem = profileTabBarItem
    }
    
    private func configureNavigationBars() {
        navigationControllers.forEach { navigationController in
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    }
}
