//
//  File.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 16.08.2021.
//

import Foundation

struct BrandPointDetail: Identifiable {
    let name, point, state: String
    
    var id: String {
        name
    }
}
