//
//  FullScreenImageController.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 05/10/2023.
//

import UIKit

class FullScreenImageController: UIViewController {
    let paths: [Photos]
    var path: String?
    var photoIndex: Int = 1
    var newPath: String? {
        didSet {
            fetchImage(with: newPath)
        }
    }
    
    var overlayView: UIView!
    
    init(paths: [Photos], path: String? = nil) {
        self.paths = paths
        self.path = path
        super.init(nibName: nil, bundle: nil)
    }
    
    let centralImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let previousButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black.withAlphaComponent(0.3)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.8).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black.withAlphaComponent(0.3)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.8).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var currentImageButton: UIBarButtonItem!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchImage(with: path)
        view.backgroundColor = .black.withAlphaComponent(0.9)
        setupUI()
        addGesture()
        navigationItem.rightBarButtonItem = currentImageButton
    }
    
    func fetchImage(with path: String?) {
        Task {
            do {
                let photo = try await Network.Client.shared.fetchImage(with: path)
                DispatchQueue.main.async {
                    self.centralImage.image = photo
                }
            } catch {
                DispatchQueue.main.async {
                    self.centralImage.image = UIImage(systemName: "film")
                }
                print(error.localizedDescription)
            }
        }
    }

}
