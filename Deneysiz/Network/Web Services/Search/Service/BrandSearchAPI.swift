//
//  CategoryDetailAPI.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.07.2021.
//

import Combine

protocol BrandSearchAPI {
    func searchBrand(payload: SearchBrandPayload) -> AnyPublisher<[BrandSearch], Error>
}
