//
//  FakeAuthService.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 26.05.2021.
//

import Foundation
import Combine

struct FakeAuthService {
    
}

extension FakeAuthService: AuthAPI {
    func signUp(username: String, password: String) -> AnyPublisher<DummyUser, Error> {
        Just(DummyUser(username: "fake", password: "fake"))
            .setFailureType(to: Error.self)
            .delay(for: 0, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func signIn(username: String, password: String) -> AnyPublisher<DummyUser, Error> {
        Just(DummyUser(username: "fake", password: "fake"))
            .setFailureType(to: Error.self)
            .delay(for: 0, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
