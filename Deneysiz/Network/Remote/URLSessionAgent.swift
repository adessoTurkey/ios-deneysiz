//
//  URLSessionAgent.swift
//  MindKit
//
//  Created by ogulcan keskin on 4.12.2020.
//  Copyright © 2020 Deep Work. All rights reserved.
//

import Combine
import Foundation

final class URLSessionAgent: BaseServiceProtocol, RequestBuilder {
    
    static let shared = URLSessionAgent()

    private var environment: EnvironmentProtocol
    private var decoder: JSONDecoder
    
    private init(environment: EnvironmentProtocol = Environment.shared, _ decoder: JSONDecoder = JSONDecoder()) {
        self.environment = environment
        self.decoder = decoder
    }
    
    func request<T: Decodable>(_ request: Request) -> AnyPublisher<Response<T>, Error> {
        let urlRequest = build(request, environment)
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { [decoder] result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func request<T: Decodable>(_ request: Request) -> AnyPublisher<T, Error> {
        let urlRequest = build(request, environment)
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

