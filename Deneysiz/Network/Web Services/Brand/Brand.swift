//
//  Brand.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.07.2021.
//

import Foundation

struct Brand {
    var id: UUID?
    var name: String?
    var parentCompany: String?
    var category: Int?
    var shopName: [String]?
    var certificate: [Certificate]?
    var hasVeganProduct: Bool?
    var parentCompanySafe: Bool?
    var vegan: Bool?
    var offerInChina: Bool?
    var isSafe: Bool?
    
    init(name: String, parentCompany: String) {
        self.name = name
        self.parentCompany = parentCompany
    }
}

extension Brand {
    static let dummies: [Brand] = [
        Brand(name: "Hawaiian Tropic", parentCompany: "Rossman"),
        Brand(name: "Flink & Sauber", parentCompany: "Dirk Rossmann"),
        Brand(name: "Sunozon", parentCompany: "L’Oréal"),
        Brand(name: "Diadermine", parentCompany: "Gliss"),
        Brand(name: "Procsin", parentCompany: "Isana")
    ]
    
    var point: String {
        let random = Int.random(in: 1...10)
        return "\(random)/10"
    }
}

struct Certificate: Codable {
    let certificate: String?
    let valid: Bool?
}
