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
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchRecognizer))
        pinchGesture.delegate = self
        centralImage.addGestureRecognizer(pinchGesture)
    }
    
    @objc func pinchRecognizer(recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .began:
            handlePinchBegan(recognizer)
        case .changed:
            handlePinchChanged(recognizer)
        case .ended, .cancelled, .failed:
            handlePinchEnded()
        default:
            break
        }
    }
    
    private func handlePinchBegan(_ recognizer: UIPinchGestureRecognizer) {
        let currentScale = centralImage.frame.size.width / centralImage.bounds.size.width
        let newScale = currentScale * recognizer.scale
        
        if newScale > 1 {
            guard let currentWindow = view.window else { return }
            createOverlay(in: currentWindow)
        }
    }
    
    private func handlePinchChanged(_ recognizer: UIPinchGestureRecognizer) {
        let scale = recognizer.scale
        centralImage.transform = centralImage.transform.scaledBy(x: scale, y: scale)
        recognizer.scale = 1.0
    }
    
    private func handlePinchEnded() {
        UIView.animate(withDuration: 0.3) {
            self.centralImage.transform = CGAffineTransform.identity
            self.overlayView?.removeFromSuperview()
        }
    }
    
    private func createOverlay(in window: UIWindow) {
        overlayView = UIView(frame: window.bounds)
        window.addSubview(overlayView)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
