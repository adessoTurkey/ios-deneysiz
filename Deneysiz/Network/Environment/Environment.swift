//
//  Environment.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 26.05.2021.
//

import Foundation

final class Environment: EnvironmentProtocol {

    static let shared = Environment()

    var baseURL: URL
    var headers: Headers?

    private init() {
        baseURL = URL(string: "")!
        headers = [:]
    }
}
