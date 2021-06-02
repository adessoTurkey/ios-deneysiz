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
    func request<T: Decodable>(_ requestObject: Request, environment: EnvironmentProtocol) -> AnyPublisher<T, Error>
    
    func request<T: Decodable>(_ requestObject: Request, environment: EnvironmentProtocol) -> AnyPublisher<Response<T>, Error>
}

extension BaseServiceProtocol {
    func requestWithDefaultEnvironment<T: Decodable>(_ requestObject: Request, with environment: EnvironmentProtocol = Environment.shared) -> AnyPublisher<T, Error> {
        self.request(requestObject, environment: environment)
    }
    
    func requestWithDefaultEnvironment<T: Decodable>(_ requestObject: Request, with environment: EnvironmentProtocol = Environment.shared) -> AnyPublisher<Response<T>, Error> {
        self.request(requestObject, environment: environment)
    }
}
