//
//  Category.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import Foundation

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
