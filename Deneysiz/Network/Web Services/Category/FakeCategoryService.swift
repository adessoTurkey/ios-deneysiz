//
//  FakeCategoryService.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import Combine
import Foundation

struct FakeCategoryService {
    
}

extension FakeCategoryService: CategoryAPI {
    func getCategories() -> AnyPublisher<[Category], Error> {
        Just(Category.categories)
            .setFailureType(to: Error.self)
            .delay(for: 0, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
