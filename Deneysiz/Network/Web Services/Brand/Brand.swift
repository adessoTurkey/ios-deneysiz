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
    var shopName: [String] = []
    var certificate: [Certificate] = []
    var hasVeganProduct: Bool?
    var parentCompanySafe: Bool?
    var vegan: Bool?
    var offerInChina: Bool?
    var isSafe: Bool?
    
    var point: Int!
    var color: Color!
}

extension Brand {
    init(
        name: String,
        parentCompany: String,
        shopName: [String],
        certificate: [Certificate],
        hasVeganProduct: Bool = Bool.random(),
        parentCompanySafe: Bool = Bool.random(),
        offerInChina: Bool = Bool.random()
    ) {
        self.name = name
        self.parentCompany = parentCompany
        self.shopName = shopName
        self.certificate = certificate
        self.hasVeganProduct = hasVeganProduct
        self.parentCompanySafe = parentCompanySafe
        self.offerInChina = offerInChina
        calculatePoint()
    }
}

extension Brand {

    var pointTitle: String {
        "\(point ?? 0)/10"
    }
    
    private mutating func calculatePoint() {
        let randomPoint = randomPoint
        color = .calculateColor(randomPoint)
        point = randomPoint
    }
    
    // MARK: MOCK DATA TO BE DELETED
    static let dummies: [Brand] = [
        Brand(name: "Hawaiian Tropic", parentCompany: "Rossman", shopName: dummyshop_3, certificate: Certificate.dummies),
        Brand(name: "Flink & Sauber", parentCompany: "Dirk Rossmann", shopName: dummyshop_6, certificate: Certificate.dummies),
        Brand(name: "Sunozon", parentCompany: "L’Oréal", shopName: dummyshop_3, certificate: Certificate.dummies),
        Brand(name: "Diadermine", parentCompany: "Gliss", shopName: dummyshop_3, certificate: Certificate.dummies),
        Brand(name: "Procsin", parentCompany: "Isana", shopName: dummyshop_6, certificate: Certificate.dummies)
    ]
    
    static let dummyshop_6 = ["rossman", "gratis", "migros", "tossman", "mosman", "fosman"]
    static let dummyshop_3 = ["rossman", "gratis", "migros"]
    
    private var randomPoint: Int {
        let random = Int.random(in: 1...10)
        return random
    }
    
    var shopPalettes: [ShopPalette] {
        self.shopName.map { name in
            Shop(rawValue: name)?.palette ?? .init(backgroundColor: .black, textColor: .white, name: name)
        }
    }
}

// MARK: Certificates
struct Certificate: Codable, Identifiable, Equatable, Hashable {
    let name: String?
    let valid: Bool?
    
    var id: String {
        name ?? ""
    }
}

extension Certificate {
    static let leapingBunny: Self = .init(name: "leapingBunny", valid: Bool.random())
    static let sittingBunny: Self = .init(name: "sittingBunny", valid: Bool.random())
    static let flower: Self = .init(name: "flower", valid: Bool.random())
    static let crueltyFree: Self = .init(name: "crueltyFree", valid: Bool.random())
    
    static let dummies: [Self] = [.leapingBunny, .sittingBunny, .flower, .crueltyFree]
}

// MARK: Shops
struct ShopPalette: Identifiable, Hashable {
    var backgroundColor, textColor: Color
    var name: String
    
    var id: String {
        name
    }
}

private enum Shop: String {
    case gratis
    case rossman
    case migros
    
    var palette: ShopPalette {
        switch self {
        case .gratis:
            return .init(backgroundColor: .purple, textColor: .yellow, name: rawValue)
        case .migros:
            return .init(backgroundColor: .orange, textColor: .white, name: rawValue)
        case .rossman:
            return .init(backgroundColor: .red, textColor: .white, name: rawValue)
        }
    }
}

extension Color {
    static func calculateColor(_ point: Int) -> Self {
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
}
