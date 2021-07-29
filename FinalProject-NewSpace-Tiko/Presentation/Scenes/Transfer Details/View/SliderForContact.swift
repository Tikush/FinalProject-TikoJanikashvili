//
//  SliderView.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit

protocol SliderForContactProtocol: AnyObject {
    var controller: CoordinatorDelegate { get }
    
    init(with controller: CoordinatorDelegate)
    func loadSlide(contact: Contact)
}

final class SliderForContact: SliderForContactProtocol {
    
    // MARK: - Private Properties
    private(set) var controller: CoordinatorDelegate
    
    // MARK: - Components of slide
    private var slider: NumbersView?
    private var sliderBackground: UIView?
    private var slideCenter: CGPoint!
    
    // MARK: - Pan Gesture
    private var panGesture: UIPanGestureRecognizer?
    // MARK: - Tap Gesture
    private var tapGesture: UITapGestureRecognizer?

    init(with controller: CoordinatorDelegate) {
        self.controller = controller
    }
    
    // MARK: Load table on slide
    func loadSlide(contact: Contact) {
        self.panGesture = nil
        self.tapGesture = nil
        self.slider = nil
        self.sliderBackground = nil
        self.controller.view.endEditing(true)
        guard let shadow = Bundle.main.loadNibNamed(Constants.NibId.numbers, owner: nil, options: nil)?.first as? NumbersView else { return }
        self.slider = shadow
        self.slider?.dataset(with: contact)
        self.slider?.delegate = self
        
        self.sliderBackground = UIView(frame: CGRect(origin: .zero, size: controller.view.bounds.size))
        self.sliderBackground?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(sliderBackground!)
        
        let sliderHeight: CGFloat = 220.0
        self.slider?.layer.cornerRadius = 10
        self.slider?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
                    closeSlideView()
                }
            }
        }
    }
}

extension SliderForContact: NumberDelegate {
    func selectedNumber(number: String, name: String, symbol: String) {
        closeSlideView()
        let split = symbol.split(separator: " ")
        controller.coordinator?.proceedToTransferMoneyPage(number: number, name: name, symbol: String(split[0].prefix(1) + split[1].prefix(1)))
    }
}
