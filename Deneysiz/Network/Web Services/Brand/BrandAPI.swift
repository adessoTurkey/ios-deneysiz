//
//  CategoryDetailAPI.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.07.2021.
//

import Combine

protocol BrandAPI {
    func getBrandsByCategory(payload: SearchBrandByCategoryPayload) -> AnyPublisher<[Brand], Error>
}

protocol BrandDetailAPI {
    func getBrandDetail(payload: BrandDetailPayload) -> AnyPublisher<[BrandDetail], Error>
}
