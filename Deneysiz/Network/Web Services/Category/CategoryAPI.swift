//
//  CategoryAPI.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import Combine

protocol CategoryAPI {
    func getCategories() -> AnyPublisher<[Category], Error>
}
