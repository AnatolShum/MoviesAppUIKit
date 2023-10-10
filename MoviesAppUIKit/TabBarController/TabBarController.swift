//
//  TabBarController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import UIKit

class TabBarController: UITabBarController {
    private let userID: String
    
    init(userID: String) {
        self.userID = userID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var moviesController: MoviesController!
    private var favouritesController: FavouritesController!
    private var searchController: SearchController!
    private var profileController: ProfileController!
    
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
        moviesController = MoviesController(collectionViewLayout: UICollectionViewFlowLayout())
        favouritesController = FavouritesController(userID: userID, collectionViewLayout: UICollectionViewFlowLayout())
        searchController = SearchController(collectionViewLayout: UICollectionViewFlowLayout())
        profileController = ProfileController()
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
