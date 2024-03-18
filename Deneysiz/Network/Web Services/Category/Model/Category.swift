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
            return (title: LocalizedStringKey("haircare"), image: Image("hair"))
        case .skincare:
            return (title: LocalizedStringKey("skincare"), image: Image("skin"))
        case .perfume:
            return (title: LocalizedStringKey("perfume"), image: Image("deodorantAndPerfume"))
        case .personalHygiene:
            return (title: LocalizedStringKey("personalHygiene"), image: Image("personal"))
        case .dentalcare:
            return (title: LocalizedStringKey("dentalcare"), image: Image("dental"))
        case .mombabycare:
            return (title: LocalizedStringKey("mombabycare"), image: Image("mombaby"))
        case .homecare:
            return (title: LocalizedStringKey("homecare"), image: Image("home"))
        }
    }
}
