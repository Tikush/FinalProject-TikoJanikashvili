//
//  UIViewExtension.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 16.07.21.
//

import UIKit

extension UIView {
    
    // MARK: - Round corners
    func cornerView(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = false
    }
}
extension UIView {
    
    // MARK: - Round top corners
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
