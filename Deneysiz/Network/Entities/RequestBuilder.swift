//
//  RequestBuilder.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 26.05.2021.
//

import Foundation

protocol RequestBuilder {
    
}

extension RequestBuilder {
    func build(_ request: Request, _ environment: EnvironmentProtocol) -> URLRequest {
        URLRequest(request, environment)
    }
}

private extension URLRequest {
    init(_ request: Request, _ environment: EnvironmentProtocol) {
        guard let url = URLComponents(request, environment)?.url else { fatalError() }
        self.init(url: url)
        httpMethod = request.method.rawValue
        environment.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
        httpBody = request.payload
    }
}

private extension URLComponents {
    init?(_ request: Request, _ environment: EnvironmentProtocol) {
        let url = environment.baseURL.appendingPathComponent(request.path)
        self.init(url: url, resolvingAgainstBaseURL: false)
    }
}
