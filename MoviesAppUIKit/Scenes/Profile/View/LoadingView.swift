//
//  LoadingView.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 06/10/2023.
//

import UIKit

class LoadingView: UIViewController {
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.style = .medium
        indicator.color = .black.withAlphaComponent(0.6)
        return indicator
    }()
    
    let activityLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading ..."
        label.textColor = .black.withAlphaComponent(0.6)
        return label
    }()
    
    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundView = ColorView(frame: self.view.bounds)
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(backgroundView)
        view.sendSubviewToBack(backgroundView)

        view.addSubview(vStack)
        vStack.addArrangedSubview(activityIndicator)
        vStack.addArrangedSubview(activityLabel)
        
        vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
   
}
