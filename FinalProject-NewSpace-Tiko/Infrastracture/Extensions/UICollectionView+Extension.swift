//
//  UICollectionView+Extension.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 16.07.21.
//

import Foundation

import UIKit

extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(class: T.Type) {
        self.register(T.nib(), forCellWithReuseIdentifier: T.identifier)
    }
    
    func registerClass<T: UICollectionViewCell>(class: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier:  T.identifier)
    }
    
    func deque<T: UICollectionViewCell>(_ classType: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
    private enum PillCellSpacing: CGFloat {
        case defaultValue = 10.0
    }
}
