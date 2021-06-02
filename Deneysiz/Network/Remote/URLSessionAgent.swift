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

    private var decoder: JSONDecoder
    
    private init(_ decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
        
    func request<T>(_ request: Request, environment: EnvironmentProtocol) -> AnyPublisher<T, Error> where T : Decodable {
        let urlRequest = build(request, environment)
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func request<T>(_ request: Request, environment: EnvironmentProtocol) -> AnyPublisher<Response<T>, Error> where T : Decodable {
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
}

