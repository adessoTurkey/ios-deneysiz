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
    
    var urlSession: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 20.0
        return URLSession(configuration: sessionConfig)
    }()
    
    private init(_ decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
        
    func request<T: Decodable>(_ request: Request, environment: EnvironmentProtocol) -> AnyPublisher<T, Error> {
        let urlRequest = build(request, environment)
        return urlSession
            .dataTaskPublisher(for: urlRequest)
            .map {
//                print(String(data: $0.data, encoding: .utf8))
                return $0.data
            }
            .decode(type: BaseResponse<T>.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .eraseToAnyPublisher()
    }
    
    func request<T: Decodable>(_ request: Request, environment: EnvironmentProtocol) -> AnyPublisher<Response<T>, Error> {
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
