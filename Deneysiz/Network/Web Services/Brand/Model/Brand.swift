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
    let parentCompany: ParentCompany
    let offerInChina: Bool
    let categoryId: String
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
