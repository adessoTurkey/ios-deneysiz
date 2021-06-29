//
//  Category.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import Foundation
import SwiftUI
struct Category: Hashable {
    let name: String
    let image: String
}

extension Category {
    static var categories: [Category] = [
        Category(name: "Makyaj", image: ""),
        Category(name: "Parfüm", image: ""),
        Category(name: "Cilt Bakım", image: ""),
        Category(name: "Tırnak Bakım", image: ""),
        Category(name: "Saç Bakım", image: ""),
        Category(name: "Saç Boyaları", image: ""),
        Category(name: "Güneş Kremleri", image: ""),
        Category(name: "Vücut Bakım", image: "")
    ]
}

enum CategoryEnum: Int, CaseIterable {
    case allBrands = 0
    case makeup
    case perfume
    case skincare
    case nailcare
    case haircare
    case hairDye
    case sunLotion
    case bodycare
}

extension CategoryEnum {
    
    typealias CategoryModel = (title: LocalizedStringKey, image: Image)
    
    var categoryModel: CategoryModel {
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
