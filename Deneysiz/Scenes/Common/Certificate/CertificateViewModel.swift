//
//  CertificateViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 30.08.2021.
//

import Combine

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
        print("\(name)-circle")
        return "\(name)-circle"
    }
    
    var description: String {
        "Lorem ipsum detail blob blob"
    }
    
    var viewType: ViewType
    
    init(certificate: Certificate) {
        self.certificate = certificate
        self.viewType = certificate.name.contains("Beauty Without Bunnies") ? .peta(["petacert", "petacert1", "petacert2", "petacert3", "petacert4"]) : .nonPeta
    }
}
