//
//  MovieDetailController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 04/10/2023.
//

import UIKit

class MovieDetailController: UIViewController {
    
    let movie: Movie
    var movieDetailView: MovieDetailView!
    private var videos: [Videos] = []
    private var key: String? = ""
    private var favouritesButton: UIBarButtonItem!
    private var trailerButton: UIButton!
   
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        movieDetailView = MovieDetailView(navigationController: navigationController!, movie: movie, frame: view.bounds)
        trailerButton = movieDetailView.trailerButton
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        favouritesButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favouritesTapped))
        favouritesButton.tintColor = .systemPink
        navigationItem.rightBarButtonItem = favouritesButton
        trailerButton.addTarget(self, action: #selector(playTrailer), for: .touchUpInside)
    }
    
    @objc func playTrailer() {
        if let key = key {
            let playerView = PlayerController(key: key)
            navigationController?.pushViewController(playerView, animated: true)
        }
    }
    
    @objc func favouritesTapped() {
        
    }
    
    func fetchVideos() {
        Network.Client.shared.get(.videos(id: movie.id)) { [weak self] (result: Result<Network.Types.Response.VideoResults, Network.Errors>) in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.videos = success.results
                    self.key = self.videoKey()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private func videoKey() -> String? {
        guard !videos.isEmpty else { 
            changeTrailerImage()
            return nil }
        
        let firstVideo = videos.first?.key
        guard firstVideo != nil else {
            changeTrailerImage()
            return nil }
        
        let filteredVideo = videos.first { $0.official == true && $0.type == "Trailer" && $0.site == "YouTube" }
        guard filteredVideo != nil else { return firstVideo }
        
        return filteredVideo?.key
    }
    
    private func changeTrailerImage() {
        DispatchQueue.main.async {
            self.trailerButton.setImage(UIImage(systemName: "play.slash.fill"), for: .normal)
        }
    }
    
}
