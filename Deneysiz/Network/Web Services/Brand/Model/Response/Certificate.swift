//
//  Certificate.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 12/08/2022.
//

import Foundation

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
