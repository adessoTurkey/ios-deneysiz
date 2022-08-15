//
//  BrandSearch.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 12/08/2022.
//

import SwiftUI

struct BrandSearch: Codable {
    let id: Int
    let name: String
    let parentCompany: ParentCompany
    let score: Int
}

extension BrandSearch {
    var pointTitle: String {
        "\(score)/10"
    }

    var color: Color {
        .calculateColor(score)
    }
}
