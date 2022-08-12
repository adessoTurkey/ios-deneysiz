//
//  FakeBrandService.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.07.2021.
//

import Combine
import Foundation

struct BrandDetailService {
    let service: BaseServiceProtocol
    
    init(service: BaseServiceProtocol = URLSessionAgent.shared) {
        self.service = service
    }
}

extension BrandDetailService: BrandDetailAPI {
    func getBrandDetail(payload: BrandDetailPayload) -> AnyPublisher<[BrandDetail], Error> {
        service.request(
            Request(
                method: .POST,
                path: "brands/detail",
                payload: payload
            ),
            environment: AppEnvironment.shared
        )
    }
}
