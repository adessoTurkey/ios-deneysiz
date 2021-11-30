//
//  FakeBrandService.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.07.2021.
//

import Combine
import Foundation

struct BrandService {
    let service: BaseServiceProtocol
    
    init(service: BaseServiceProtocol = URLSessionAgent.shared) {
        self.service = service
    }
}

extension BrandService: BrandAPI {
    func getBrandsByCategory(payload: SearchBrandByCategoryPayload) -> AnyPublisher<[Brand], Error> {
        service.request(
            Request(
                method: .POST,
                path: "brands/byCategory",
                payload: payload
            ),
            environment: AppEnvironment.shared
        )
    }
}
