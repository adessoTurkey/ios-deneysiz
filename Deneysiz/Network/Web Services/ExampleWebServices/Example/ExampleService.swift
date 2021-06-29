//
//  ExampleService.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 23.06.2021.
//

import Combine

struct ExampleService {
    let service: BaseServiceProtocol
    
    init(service: BaseServiceProtocol = URLSessionAgent.shared) {
        self.service = service
    }
}

extension ExampleService: ExampleAPI {
    func test() -> AnyPublisher<[ExampleModel], Error> {
        service.request(Request(method: .GET, path: ""), environment: ExampleEnvironment.shared)
    }
}
