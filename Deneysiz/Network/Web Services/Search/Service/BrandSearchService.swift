//
//  FakeBrandService.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.07.2021.
//

import Combine
import Foundation

struct BrandSearchService {
    let service: BaseServiceProtocol
    
    init(service: BaseServiceProtocol = URLSessionAgent.shared) {
        self.service = service
    }
}

extension BrandSearchService: BrandSearchAPI {

    func searchBrand(payload: SearchBrandPayload) -> AnyPublisher<[BrandSearch], Error> {
        service.request(
            Request(
                method: .POST,
                path: "brands/search",
                payload: payload
            ),
            environment: AppEnvironment.shared
        )
    }
}
