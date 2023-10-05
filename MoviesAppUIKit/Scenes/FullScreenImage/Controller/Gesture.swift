//
//  Gesture.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 05/10/2023.
//

import Foundation
import UIKit

extension FullScreenImageController: UIGestureRecognizerDelegate {
    func addGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchRecofnizer))
        pinchGesture.delegate = self
        centralImage.addGestureRecognizer(pinchGesture)
    }
    
    @objc func pinchRecofnizer(recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .began {
            let currentScale = centralImage.frame.size.width / centralImage.bounds.size.width
            let newScale = currentScale * recognizer.scale
            if newScale > 1 {
                guard let currentWindow = view.window else { return }
                overlayView = UIView.init(frame: CGRect(
                    x: 0,
                    y: 0,
                    width: Int(currentWindow.frame.size.width),
                    height: Int(currentWindow.frame.size.height)
                ))
                
                overlayView.backgroundColor = .black
                overlayView.alpha = 0.7
                currentWindow.addSubview(overlayView)
                
                initialCenter = recognizer.location(in: currentWindow)
                windowImageView = UIImageView.init(image: centralImage.image)
                windowImageView?.contentMode = .scaleAspectFill
                windowImageView?.clipsToBounds = true
                
                let point = centralImage.convert(centralImage.frame.origin, to: nil)
                startRect = CGRect(x: point.x, y: point.y, width: centralImage.frame.size.width, height: centralImage.frame.size.height)
                
                windowImageView?.frame = startRect
                currentWindow.addSubview(windowImageView!)
                centralImage.isHidden = true
            }
            
        } else if recognizer.state == .changed {
            guard let currentWindow = view.window,
                  let initialCenter = initialCenter,
                  let windowImageWidth = windowImageView?.frame.size.width else { return }
            let currentScale = windowImageWidth / startRect.size.width
            let newScale = currentScale * recognizer.scale
            let pinchCenter = CGPoint(
                x: recognizer.location(in: currentWindow).x - (currentWindow.bounds.midX),
                y: recognizer.location(in: currentWindow).y - (currentWindow.bounds.midY)
            )
            
            let centerXDiff = initialCenter.x - recognizer.location(in: currentWindow).x
            let centerYDiff = initialCenter.y - recognizer.location(in: currentWindow).y
            let zoomScale = (newScale * windowImageWidth >= centralImage.frame.size.width) ? newScale : currentScale
            let transform = currentWindow.transform
                .translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                .scaledBy(x: zoomScale, y: zoomScale)
                .translatedBy(x: -centerXDiff, y: -centerYDiff)
            
            windowImageView?.transform = transform
            recognizer.scale = 1
            
        } else if recognizer.state == .ended || recognizer.state == .failed || recognizer.state == .cancelled {
            guard let windowImageView = windowImageView else { return }
            UIView.animate(withDuration: 0.3) {
                windowImageView.transform = CGAffineTransform.identity
            } completion: { _ in
                self.windowImageView?.removeFromSuperview()
                self.overlayView.removeFromSuperview()
                self.centralImage.isHidden = false
            }
            
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
