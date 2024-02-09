//
//  PlayerController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 05/10/2023.
//

import UIKit
import YouTubeiOSPlayerHelper

class PlayerController: UIViewController, YTPlayerViewDelegate {
    let key: String
    
    private lazy var player: YTPlayerView = {
        return YTPlayerView()
    }()
    
    init(key: String) {
        self.key = key
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        player = YTPlayerView()
        player.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(player)
        NSLayoutConstraint.activate([
            player.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            player.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            player.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            player.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        player.load(withVideoId: key)
    }

}
