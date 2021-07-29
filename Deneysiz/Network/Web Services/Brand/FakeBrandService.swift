//
//  FakeBrandService.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.07.2021.
//

import Combine
import Foundation

struct FakeBrandService {
    
}

extension FakeBrandService: BrandAPI {
    func getBrandsByCategory(category: CategoryEnum) -> AnyPublisher<[Brand], Error> {
        return Just(Brand.dummies)
            .setFailureType(to: Error.self)
            .delay(for: 2, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
