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
    let name: String
    let valid: Bool
    
    var id: String {
        name
    }
    var certType: CertificateType? {
        CertificateType(rawValue: name)
    }
}

enum CertificateType: String {
    case leapingBunny = "Leaping Bunny"
    case vlabel = "V-Label"
    case beautyWithoutBunnies = "Beauty Without Bunnies"
    case veganSociety = "Vegan Society"
}

extension Certificate {
    static let leapingBunnyCert: Self = .init(name: "Leaping Bunny", valid: Bool.random())
    static let vlabelCert: Self = .init(name: "V-Label", valid: Bool.random())
    static let beautyWithoutBunniesCert: Self = .init(name: "Beauty Without Bunnies", valid: Bool.random())
    static let veganSocietyCert: Self = .init(name: "Vegan Society", valid: Bool.random())
    
    static let dummies: [Self] = [.leapingBunnyCert, .vlabelCert, .beautyWithoutBunniesCert, .veganSocietyCert]
}

struct ParentCompany: Codable {
    let name: String?
    let safe: Bool?
}

struct Category: Codable {
    let categoryId: String
}

enum CategoryEnum: Int, CaseIterable {
    case makeup = 0
    case haircare
    case skincare
    case perfume
    case personalHygiene
    case dentalcare
    case mombabycare
    case homecare
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
        case .haircare:
            return (title: LocalizedStringKey("haircare"), image: Image("haircare"))
        case .skincare:
            return (title: LocalizedStringKey("skincare"), image: Image("skincare"))
        case .perfume:
            return (title: LocalizedStringKey("perfume"), image: Image("perfume"))
        case .personalHygiene:
            return (title: LocalizedStringKey("personalHygiene"), image: Image("personalHygiene"))
        case .dentalcare:
            return (title: LocalizedStringKey("dentalcare"), image: Image("dentalcare"))
        case .mombabycare:
            return (title: LocalizedStringKey("mombabycare"), image: Image("mombabycare"))
        case .homecare:
            return (title: LocalizedStringKey("homecare"), image: Image("homecare"))
        }
    }
}
