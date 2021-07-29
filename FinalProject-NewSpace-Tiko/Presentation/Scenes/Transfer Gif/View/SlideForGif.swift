//
//  SlideForGif.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 23.07.21.
//

import UIKit
import Kingfisher

protocol SliderForGifProtocol: AnyObject {
    var controller: CoordinatorDelegate { get }
    var delegate: SlideDelegate? { get set }
    
    init(with controller: CoordinatorDelegate)
    func loadSlide(gifSearching: Bool)
}

protocol SlideDelegate: AnyObject {
    func selectGif(url: String)
}

final class SliderForGif: SliderForGifProtocol {
    
    // MARK: - Private Properties
    private(set) var controller: CoordinatorDelegate
    
    // MARK: - Components of slide
    private var slider: Gifs?
    private var sliderBackground: UIView?
    private var slideCenter: CGPoint!
    
    // MARK: - Pan Gesture
    private var panGesture: UIPanGestureRecognizer?
    // MARK: - Tap Gesture
    private var tapGesture: UITapGestureRecognizer?
    
    // MARK: - Internal Properties
    weak var delegate: SlideDelegate?

    init(with controller: CoordinatorDelegate) {
        self.controller = controller
    }
    
    // MARK: Load table on slide
    func loadSlide(gifSearching: Bool) {
        self.panGesture = nil
        self.tapGesture = nil
        self.slider = nil
        self.sliderBackground = nil
        self.controller.view.endEditing(true)
        guard let shadow = Bundle.main.loadNibNamed(Constants.NibId.gif, owner: nil, options: nil)?.first as? Gifs else { return }
        self.slider = shadow
        self.slider?.delegate = self
        
        self.sliderBackground = UIView(frame: CGRect(origin: .zero, size: controller.view.bounds.size))
        self.sliderBackground?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(sliderBackground!)
        
        let sliderHeight: CGFloat = 420.0
        self.slider?.frame.origin.y = controller.view.frame.height + sliderHeight
        self.slider?.frame.size.height = sliderHeight
        self.slider?.frame.size.width = controller.view.frame.size.width
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(slider!)
        
        UIView.animate(withDuration: 0.5) {
            self.slider?.frame.origin.y = self.controller.view.bounds.size.height - sliderHeight
        }
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.closeSlideView))
        self.panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.downScrollSlide))
        self.slider?.addGestureRecognizer(self.panGesture!)
        self.sliderBackground?.addGestureRecognizer(self.tapGesture!)
    }
    
    @objc func closeSlideView() {
        UIView.animate(withDuration: 0.8) {
            self.sliderBackground?.alpha = 0.0
            self.slider?.frame.origin.y = self.controller.view.frame.size.height
        } completion: { [weak self] _ in
            UIView.animate(withDuration: 0.8) {
                self?.slider?.isHidden = true
            }
        }
    }
    
    @objc func downScrollSlide(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.slider)
        if let gestureView = gesture.view {
            if gestureView.frame.origin.y < 450.0 {
                gestureView.frame.origin = CGPoint(x: gestureView.frame.origin.x, y: 450.0)
            } else if let centerX = gesture.view?.center.x, let centerY = gesture.view?.center.y {
                gesture.view?.center = CGPoint(x: centerX, y: centerY + translation.y)
                gesture.setTranslation(CGPoint.zero, in: self.slider!)
            }
            if gesture.state == .ended {
                if gestureView.frame.origin.y > 450.0 {
                    print(gestureView.frame.origin.y)
                    closeSlideView()
                }
            }
        }
    }
}

extension SliderForGif: GifsDelegate {
    func selectGif(imageUrl: String) {
        delegate?.selectGif(url: imageUrl)
        self.closeSlideView()
    }
}
