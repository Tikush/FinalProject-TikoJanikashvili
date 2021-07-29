//
//  SlideForAccount.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 26.07.21.
//

import UIKit

protocol SliderForAccountProtocol: AnyObject {
    var controller: CoordinatorDelegate { get }
    
    init(with controller: CoordinatorDelegate)
    func loadSlide()
}

final class SliderForAccount: SliderForAccountProtocol {
    
    // MARK: - Private Properties
    private(set) var controller: CoordinatorDelegate
    
    private var slider: AccountSettingView?
    private var sliderBackground: UIView?

    init(with controller: CoordinatorDelegate) {
        self.controller = controller
    }
    
    func loadSlide() {
        self.sliderBackground = UIView(frame: CGRect(origin: .zero, size: self.controller.view.bounds.size))
        guard let shadow = Bundle.main.loadNibNamed(Constants.NibId.account, owner: nil, options: nil)?.first as? AccountSettingView else { return }
        slider = shadow
        slider?.delegate = self
        
        let slideHeight: CGFloat = controller.view.frame.size.height/2.4
        slider = shadow
        slider?.backgroundColor = .white
        
        // Create shadow layer
        sliderBackground?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(sliderBackground!)
        
        
        slider?.frame.origin.y = controller.view.frame.size.height
        slider?.frame.size.height = slideHeight
        slider?.frame.size.width = controller.view.frame.size.width
        
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(slider!)
        UIView.animate(withDuration: 0.5) {
            self.slider?.frame.origin.y = self.controller.view.frame.size.height - slideHeight
        }
        
        sliderBackground?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeSlide)))
    }
    
    @objc func closeSlide() {
        UIView.animate(withDuration: 0.5) {
            self.sliderBackground?.alpha = 0.0
            self.slider?.frame.origin.y = self.controller.view.frame.size.height
        }
    }
  
}

extension SliderForAccount: MoveOtherScreenDelegate {
    func selectLogOut() {
        closeSlide()
        controller.coordinator?.proceedToWelcomePage()
    }
}

