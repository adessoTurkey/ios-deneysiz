//
//  CertificateViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 30.08.2021.
//

import Combine

class CertificateViewModel: ObservableObject {
    private let certificate: Certificate
    
    var name: String {
        certificate.name ?? ""
    }
    
    var image: String {
        "\(name)-circle"
    }
    
    var description: String {
        "Lorem ipsum detail blob blob"
    }
    
    init(certificate: Certificate) {
        self.certificate = certificate
    }
}
