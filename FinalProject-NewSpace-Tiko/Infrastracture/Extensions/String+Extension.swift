//
//  String+Extension.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 24.07.21.
//

import Foundation

extension String {
    var isNotEmpty: String? {
        if self.isEmpty { return nil }
        return self
    }
}
