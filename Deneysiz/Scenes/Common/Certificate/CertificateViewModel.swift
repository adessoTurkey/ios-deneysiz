//
//  CertificateViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 30.08.2021.
//

import Combine
import SwiftUI

class CertificateViewModel: ObservableObject {
    
    enum ViewType {
        case peta([String])
        case nonPeta
    }
    
    private let certificate: Certificate
    
    var name: String {
        certificate.name
    }
    
    var image: String {
        "\(name)-circle"
    }
    
    var title: String {
        switch certificate {
        case .leapingBunny:
            return "LEAPING BUNNY (CCIC)"
        case .vlabel:
            return "V-LABEL"
        case .beautyWithoutBunnies:
            return "BEAUTY WITHOUT BUNNIES (PeTA)"
        case .veganSociety:
            return "SUNFLOWER (Vegan Society)"
        default:
            return ""
        }
    }
    
    var description: LocalizedStringKey {
        switch certificate {
        case .leapingBunny:
            return LocalizedStringKey("leaping_bunny.description")
        case .vlabel:
            return LocalizedStringKey("v_label.description")
        case .beautyWithoutBunnies:
            return LocalizedStringKey("beauty_without_bunnies.description")
        case .veganSociety:
            return LocalizedStringKey("vegan_society.description")
        default:
            return ""
        }
    }
    
    var websiteUrl: LocalizedStringKey {
        switch certificate {
        case .leapingBunny:
            return LocalizedStringKey("leaping_bunny.website_url")
        case .vlabel:
            return LocalizedStringKey("v_label.website_url")
        case .beautyWithoutBunnies:
            return LocalizedStringKey("beauty_without_bunnies.website_url")
        case .veganSociety:
            return LocalizedStringKey("vegan_society.website_url")
        default:
            return ""
        }
    }
    
    var viewType: ViewType
    
    init(certificate: Certificate) {
        self.certificate = certificate
        self.viewType = certificate.name.contains("Beauty Without Bunnies") ? .peta(["petacert", "petacert1", "petacert2", "petacert3", "petacert4"]) : .nonPeta
    }
}
