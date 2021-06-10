//
//  AuthService.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 26.05.2021.
//

import Foundation
import Combine

struct AuthService {
    let service: BaseServiceProtocol
    
    init(service: BaseServiceProtocol = URLSessionAgent.shared) {
        self.service = service
    }
    
    private enum AuthServiceEndpoint: String {
        case signIn
        case signUp
    }
}

extension AuthService: AuthAPI {
    func signUp(username: String, password: String) -> AnyPublisher<DummyUser, Error> {
        service.requestWithDefaultEnvironment(Request(path: AuthServiceEndpoint.signUp(), payload: DummyUser(username: username, password: password)))
    }
    
    func signIn(username: String, password: String) -> AnyPublisher<DummyUser, Error> {
        service.requestWithDefaultEnvironment(Request(path: AuthServiceEndpoint.signIn(), payload: DummyUser(username: username, password: password)))
    }
}

struct DummyUser: Codable {
    let username, password: String
}
