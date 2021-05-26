//
//  AuthAPI.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 26.05.2021.
//

import Combine

protocol AuthAPI {
    func signUp(username: String, password: String) -> AnyPublisher<DummyUser, Error>
    func signIn(username: String, password: String) -> AnyPublisher<DummyUser, Error>
}
