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
    
    var title: LocalizedStringKey {
        switch self {
        case .allBrands:
            return LocalizedStringKey("allBrands")
        case .makeup:
            return LocalizedStringKey("makeup")
        case .perfume:
            return LocalizedStringKey("perfume")
        case .skincare:
            return LocalizedStringKey("skincare")
        case .nailcare:
            return LocalizedStringKey("nailcare")
        case .haircare:
            return LocalizedStringKey("haircare")
        case .hairDye:
            return LocalizedStringKey("hairDye")
        case .sunLotion:
            return LocalizedStringKey("sunLotion")
        case .bodycare:
            return LocalizedStringKey("bodycare")
        }
    }
    
    var image: Image {
        switch self {
        case .allBrands:
            return Image("allBrands")
        case .makeup:
            return Image("makeup")
        case .perfume:
            return Image("perfume")
        case .skincare:
            return Image("skincare")
        case .nailcare:
            return Image("mombaby")
        case .haircare:
            return Image("haircare")
        case .hairDye:
            return Image("personalHygiene")
        case .sunLotion:
            return Image("personalHygiene")
        case .bodycare:
            return Image("oralcare")
        }
    }
    
}
