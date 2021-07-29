//
//  UIButtonExtension.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 16.07.21.
//

import UIKit

extension UIButton {
    
    // MARK: - Round corners
    func customCornerButton(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = true
    }
}
