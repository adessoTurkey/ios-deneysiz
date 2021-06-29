//
//  ExampleAPI.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 23.06.2021.
//

import Combine

protocol ExampleAPI {
    func test() -> AnyPublisher<[ExampleModel], Error>
}

// https://jsonplaceholder.typicode.com/posts

struct ExampleModel: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
