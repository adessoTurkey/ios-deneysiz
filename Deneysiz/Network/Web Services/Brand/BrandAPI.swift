//
//  CategoryDetailAPI.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.07.2021.
//

import Combine

protocol BrandAPI {
    func getBrandsByCategory(category: CategoryEnum) -> AnyPublisher<[BrandDummy], Error>
}
