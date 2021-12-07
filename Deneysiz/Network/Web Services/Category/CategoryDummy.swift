//
//  Category.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import Foundation
import SwiftUI

struct BrandBase: Codable {
    let status: Int
    let data: [Brand]
    let message: String
}

struct BrandSearchBase: Codable {
    let status: Int
    let brandSearchs: [BrandSearch]
    let message: String
}

struct BrandSearch: Codable {
    let id: Int
    let name: String
    let parentCompany: ParentCompany
    let score: Int
}

struct Certificate: Codable, Identifiable, Hashable {
    var id: String {
        name
    }
    let name: String
    let valid: Bool
}

extension Certificate {
    static let leapingBunny: Self = .init(name: "Leaping Bunny", valid: Bool.random())
    static let vlabel: Self = .init(name: "V-Label", valid: Bool.random())
    static let beautyWithoutBunnies: Self = .init(name: "Beauty Without Bunnies", valid: Bool.random())
    static let veganSociety: Self = .init(name: "Vegan Society", valid: Bool.random())
    
    static let dummies: [Self] = [.leapingBunny, .vlabel, .beautyWithoutBunnies, .veganSociety]
}

struct ParentCompany: Codable {
    let name: String
    let safe: Bool
}

struct Category: Codable {
    let categoryId: String
}

enum CategoryEnum: Int, CaseIterable {
    case makeup = 0
    case perfume
    case skincare
    case nailcare
    case haircare
    case hairDye
    case sunLotion
    case bodycare
    case allBrands
}

extension CategoryEnum {
    
    typealias CategoryUIModel = (title: LocalizedStringKey, image: Image)
    
    var categoryModel: CategoryUIModel {
        switch self {
        case .allBrands:
            return (title: LocalizedStringKey("allBrands"), image: Image("allBrands"))
        case .makeup:
            return (title: LocalizedStringKey("makeup"), image: Image("makeup"))
        case .perfume:
            return (title: LocalizedStringKey("perfume"), image: Image("perfume"))
        case .skincare:
            return (title: LocalizedStringKey("skincare"), image: Image("skincare"))
        case .nailcare:
            return (title: LocalizedStringKey("nailcare"), image: Image("mombaby"))
        case .haircare:
            return (title: LocalizedStringKey("haircare"), image: Image("haircare"))
        case .hairDye:
            return (title: LocalizedStringKey("hairDye"), image: Image("personalHygiene"))
        case .sunLotion:
            return (title: LocalizedStringKey("sunLotion"), image: Image("personalHygiene"))
        case .bodycare:
            return (title: LocalizedStringKey("bodycare"), image: Image("oralcare"))
        }
    }
}
