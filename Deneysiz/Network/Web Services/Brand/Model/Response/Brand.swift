//
//  Brand.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.12.2021.
//

import Foundation
import SwiftUI

struct Brand: Codable {
    let id: Int
    let name: String
    let parentCompany: ParentCompany?
    let offerInChina: Bool
    let categoryId: [String]
    let certificates: [Certificate]
    let safe, vegan, veganProduct: Bool
    let score: Int
    let description, createdAt: String
}

extension Brand {
    var pointTitle: String {
        "\(score)/10"
    }

    var color: Color {
        .calculateColor(score)
    }
}

extension Brand {
    static let dummies: [Brand] = [
        Brand(
            id: 3,
            name: "Hawaiian Tropic",
            parentCompany: .init(name: "Rosmman", safe: true),
            offerInChina: true, categoryId: ["1", "2"], certificates: Certificate.dummies,
            safe: true,
            vegan: true,
            veganProduct: true,
            score: 10,
            description: "description",
            createdAt: "10/10/21"),
        Brand(
            id: 2,
            name: "Flink & Sauber",
            parentCompany: .init(name: "Dirk Rossmann", safe: false),
            offerInChina: true,
            categoryId: ["1", "2"],
            certificates: Certificate.dummies,
            safe: true,
            vegan: true,
            veganProduct: true,
            score: 10,
            description: "description",
            createdAt: "03/03/21")
    ]
}

extension Brand: Equatable {
    static func == (lhs: Brand, rhs: Brand) -> Bool {
        lhs.id == rhs.id
    }
}
