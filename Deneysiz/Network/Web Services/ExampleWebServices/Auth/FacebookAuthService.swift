//
//  AuthService.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 26.05.2021.
//

import Foundation
import Combine

struct FacebookAuthService {
    let service: BaseServiceProtocol
    private let facebookEnvironment = FacebookEnvironment()
    
    init(service: BaseServiceProtocol = URLSessionAgent.shared) {
        self.service = service
    }
}

extension FacebookAuthService: AuthAPI {
    func signUp(username: String, password: String) -> AnyPublisher<DummyUser, Error> {
        service.request(Request(path: "/signup", payload: DummyUser(username: username, password: password)), environment: facebookEnvironment)
    }
    func signIn(username: String, password: String) -> AnyPublisher<DummyUser, Error> {
        service.request(Request(path: "/signIn", payload: DummyUser(username: username, password: password)), environment: facebookEnvironment)
    }
}

private struct FacebookEnvironment: EnvironmentProtocol {
    var baseURL: URL
    var headers: Headers?

    init() {
        guard let url = URL(string: "https://facebook.com") else { fatalError() }
        baseURL = url
    }
}
