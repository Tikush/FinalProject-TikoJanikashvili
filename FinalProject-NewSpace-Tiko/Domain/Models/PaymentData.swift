//
//  Payments.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 20.07.21.
//

import Foundation

struct PaymentData: Codable {
    let data: PaymentResponse
}

struct PaymentResponse:  Codable {
    let categories: [Categories]
    let companies: [Companies]
}

struct Categories: Codable {
    let name: String?
    let picture: String?
    let companyIds: [Int]?
}

struct Companies: Codable {
    let name: String?
    let companyId: Int?
    let picture: String?
}
