//
//  File.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 16.08.2021.
//

import Foundation
import SwiftUI

struct BrandPointDetailUIModel: Identifiable {
    let name, point, state: String
    let color: Color
    
    var id: String {
        name
    }
    
    var localizedKey: LocalizedStringKey {
        .init(name)
    }
}
