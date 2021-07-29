//
//  Contact.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit

class Contact {
    let name: String
    let lastName: String
    let number: String?
    let numbers: [String]
    let symbol: String
    let picture: Data?
    
    init(name: String, lastName: String, number: String, numbers: [String], firstSymbol: String, picture: Data?) {
        self.name = name
        self.lastName = lastName
        self.number = number
        self.numbers = numbers
        self.symbol = firstSymbol
        self.picture = picture
    }
}
