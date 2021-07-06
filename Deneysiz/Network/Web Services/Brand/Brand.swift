//
//  Brand.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.07.2021.
//

import Foundation
import SwiftUI

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
    
    var point: Int!
    var color: Color!
    
    init(name: String, parentCompany: String) {
        self.name = name
        self.parentCompany = parentCompany
        calculatePoint()
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
    
    private mutating func calculatePoint() {
        let randomPoint = randomPoint
        color = calculateColor(randomPoint)
        point = randomPoint
    }
    
    private func calculateColor(_ point: Int) -> Color {
        switch point {
        case let point where point > 8:
            return .superHighPointGreen
        case let point where point > 6:
            return .highPointGreen
        case let point where point > 3:
            return .midPointYellow
        case let point where point > 2:
            return .lowPointOrange
        case let point where point >= 1:
            return .lowPointRed
        default:
            return .black
        }
    }
    
    private var randomPoint: Int {
        let random = Int.random(in: 1...10)
        return random
    }
    
    var pointTitle: String {
        "\(point ?? 0)/10"
    }
}

struct Certificate: Codable {
    let certificate: String?
    let valid: Bool?
}
