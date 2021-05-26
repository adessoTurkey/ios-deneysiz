//
//  BaseServiceProtocol.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 25.05.2021.
//

import Foundation
import Combine

struct Response<T> {
    let value: T
    let response: URLResponse
}

protocol BaseServiceProtocol {
    func request<T: Decodable>(_ request: Request) -> AnyPublisher<Response<T>, Error>
    func request<T: Decodable>(_ request: Request) -> AnyPublisher<T, Error>
}
