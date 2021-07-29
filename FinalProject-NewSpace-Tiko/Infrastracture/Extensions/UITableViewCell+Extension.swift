//
//  UITableViewCell+Extension.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 16.07.21.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
